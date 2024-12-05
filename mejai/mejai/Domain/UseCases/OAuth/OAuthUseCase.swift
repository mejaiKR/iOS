//
//  OAuthUseCase.swift
//  mejai
//
//  Created by 지연 on 11/27/24.
//

import AuthenticationServices
import Combine
import Foundation

import KakaoSDKCommon

final class OAuthUseCase: OAuthLoginUseCaseProtocol {
    private let loginServices: [OAuthLoginServiceProtocol]
    private let networkService: NetworkServiceProtocol
    private let keychainService: KeychainServiceProtocol
    
    init(
        loginServices: [OAuthLoginServiceProtocol],
        networkService: NetworkServiceProtocol,
        keychainService: KeychainServiceProtocol
    ) {
        self.loginServices = loginServices
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    func login(with provider: OAuthProvider) -> AnyPublisher<OAuthResult, Never> {
        guard let service = loginServices.first(where: { $0.provider == provider }) else {
            return Just(OAuthResult.failure(.unsupportedProvider))
                .eraseToAnyPublisher()
        }
        
        return service.login()
            .flatMap { self.verifyUser(provider: provider, id: $0) }
            .catch { error in
                Just(OAuthResult.failure(error))
            }
            .eraseToAnyPublisher()
    }
    
    private func verifyUser(
        provider: OAuthProvider,
        id: String
    ) -> AnyPublisher<OAuthResult, OAuthError> {
        print("👩🏻‍💻", provider, id)
        let target = UserAPI.postLogin(socialId: id, socialType: provider.rawValue)
        return networkService.request(target, responseType: PostLoginResponse.self)
            .tryMap { response in
                try self.saveTokens(
                    accessToken: response.accessToken,
                    refreshToken: response.refreshToken
                )
                return OAuthResult.success
            }
            .mapError { self.mapError($0) }
            .eraseToAnyPublisher()
    }
    
    private func saveTokens(accessToken: String, refreshToken: String) throws {
        do {
            try keychainService.save(accessToken, for: .accessToken)
            try keychainService.save(accessToken, for: .refreshToken)
        } catch {
            throw OAuthError.tokenSaveFailed
        }
    }
    
    private func mapError(_ error: Error) -> OAuthError {
        print("👩🏻‍💻 Error occurred:", error)
        if let oauthError = error as? OAuthError {
            return oauthError
        }
        
        if let networkError = error as? NetworkError {
            switch networkError {
            case .serverError(let statusCode):
                print("👩🏻‍💻 Network error with status code:", statusCode)
                switch statusCode {
                case 400:
                    return .invalidRequest
                case 401:
                    return .unauthorized
                case 404:
                    return .userNotFound
                default:
                    return .networkError(networkError)
                }
            default:
                return .networkError(networkError)
            }
        }
        return .unknown(error)
    }
}
