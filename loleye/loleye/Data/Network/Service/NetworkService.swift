//
//  NetworkService.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Combine
import Foundation

final class NetworkService: NetworkServiceProtocol {
    private let session = URLSession.shared
    private let keychainService: KeychainServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
    }
    
    func request<T: Decodable>(
        _ target: TargetType,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        guard let request = RequestBuilder.buildURLRequest(
            from: target,
            try? keychainService.retrieve(for: .accessToken)
        ) else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                switch httpResponse.statusCode {
                case 200...299:
                    return data
                case 401:
                    throw NetworkError.unauthorized
                case 403:
                    throw NetworkError.tokenExpired
                case 400...499:
                    throw NetworkError.clientError(statusCode: httpResponse.statusCode)
                case 500...599:
                    throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                default:
                    throw NetworkError.unknown(
                        NSError(domain: "HTTPError", code: httpResponse.statusCode)
                    )
                }
            }
            .catch { [weak self] error -> AnyPublisher<Data, NetworkError> in
                print("catch", error, responseType)
                guard let self = self else {
                    return Fail(error: NetworkError.unknown(error)).eraseToAnyPublisher()
                }
                // 재시도 로직
                switch error {
                case NetworkError.tokenExpired:
                    return self.refreshToken(target, responseType: responseType)
                default:
                    return Fail(error: NetworkError.unknown(error)).eraseToAnyPublisher()
                }
            }
            .map { data -> Data in // 빈 데이터 처리 로직 추가
                if data.isEmpty {
                    return "{}".data(using: .utf8)! // 빈 JSON 객체로 처리
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if error is DecodingError {
                    return NetworkError.decodingError
                } else {
                    return NetworkError.unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func refreshToken<T: Decodable>(
        _ target: TargetType,
        responseType: T.Type
    ) -> AnyPublisher<Data, NetworkError> {
        guard let refreshToken = try? keychainService.retrieve(for: .refreshToken) else {
            return Fail(error: NetworkError.unauthorized).eraseToAnyPublisher()
        }
        
        let refreshTarget = UserAPI.postRefresh(refreshToken: refreshToken)
        
        return request(refreshTarget, responseType: PostRefreshResponse.self)
            .flatMap { [weak self] response -> AnyPublisher<Data, NetworkError> in
                guard let self = self else {
                    return Fail(error: NetworkError.unknown(NSError(domain: "Error", code: -1)))
                        .eraseToAnyPublisher()
                }
                do {
                    print("👩🏻‍💻 새로운 토큰 저장")
                    try self.keychainService.save(response.accessToken, for: .accessToken)
                    try self.keychainService.save(response.refreshToken, for: .refreshToken)
                    
                    guard let request = RequestBuilder.buildURLRequest(
                        from: target,
                        try? keychainService.retrieve(for: .accessToken)
                    ) else {
                        return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
                    }
                    print("👩🏻‍💻 재발급된 토큰으로 원래 요청 다시 실행")
                    return session.dataTaskPublisher(for: request)
                        .tryMap { data, response -> Data in
                            guard let httpResponse = response as? HTTPURLResponse else {
                                throw NetworkError.invalidResponse
                            }
                            switch httpResponse.statusCode {
                            case 200...299:
                                return data
                            case 401:
                                throw NetworkError.unauthorized
                            case 403:
                                throw NetworkError.tokenExpired
                            case 400...499:
                                throw NetworkError.clientError(statusCode: httpResponse.statusCode)
                            case 500...599:
                                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                            default:
                                throw NetworkError.unknown(
                                    NSError(domain: "HTTPError", code: httpResponse.statusCode)
                                )
                            }
                        }
                        .mapError { error in
                            if let networkError = error as? NetworkError {
                                return networkError
                            } else if error is DecodingError {
                                return NetworkError.decodingError
                            } else {
                                return NetworkError.unknown(error)
                            }
                        }
                        .eraseToAnyPublisher()
                } catch {
                    return Fail(error: NetworkError.unknown(error)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
