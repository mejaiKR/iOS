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
                print("catch", error)
                guard let self = self else {
                    return Fail(error: NetworkError.unknown(error)).eraseToAnyPublisher()
                }
                // 재시도 로직
                switch error {
                case NetworkError.tokenExpired:
                    return self.refreshToken()
                        .flatMap { _ -> AnyPublisher<Data, NetworkError> in
                            guard let retryRequest = RequestBuilder.buildURLRequest(
                                from: target,
                                try? self.keychainService.retrieve(for: .accessToken)
                            ) else {
                                return Fail(error: NetworkError.invalidRequest)
                                    .eraseToAnyPublisher()
                            }
                            return self.session.dataTaskPublisher(for: retryRequest)
                                .map(\.data) // 튜플에서 Data만 추출
                                .mapError { NetworkError.unknown($0) }
                                .eraseToAnyPublisher()
                        }
                        .eraseToAnyPublisher()
                default:
                    return Fail(error: NetworkError.unknown(error)).eraseToAnyPublisher()
                }
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
    
    private func refreshToken() -> AnyPublisher<Void, NetworkError> {
        guard let refreshToken = try? keychainService.retrieve(for: .refreshToken) else {
            return Fail(error: NetworkError.unauthorized).eraseToAnyPublisher()
        }
        
        let target = UserAPI.postRefresh(refreshToken: refreshToken)
        return self.request(target, responseType: PostRefreshResponse.self)
            .handleEvents(receiveOutput: { [weak self] response in
                // 새로운 토큰 저장
                try? self?.keychainService.save(response.accessToken, for: .accessToken)
                try? self?.keychainService.save(response.refreshToken, for: .refreshToken)
            })
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
