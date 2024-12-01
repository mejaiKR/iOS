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
    
    func login(with provider: OAuthProvider) -> AnyPublisher<OAuthResult, OAuthError> {
        guard let service = loginServices.first(where: { $0.provider == provider }) else {
            return Fail(error: .unsupportedProvider).eraseToAnyPublisher()
        }
        
        return service.login()
            .flatMap { self.verifyUser(provider: provider, id: $0) }
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
                try self.saveTokens(accessToken: response.accessToken)
                return OAuthResult.success
            }
            .mapError { self.mapError($0) }
            .eraseToAnyPublisher()
    }
    
    private func saveTokens(accessToken: String/*, refreshToken: String*/) throws {
        do {
            try keychainService.save(accessToken, for: .accessToken)
//            try keychainService.save(refreshToken, for: .refreshToken)
        } catch {
            throw OAuthError.tokenSaveFailed
        }
    }
    
    private func mapError(_ error: Error) -> OAuthError {
        print(error)
        if let oauthError = error as? OAuthError {
            return oauthError
        }
        if let networkError = error as? NetworkError {
            switch networkError {
            case .serverError(let statusCode) where statusCode == 404:
                return .userNotFound
            case .serverError(let statusCode) where statusCode == 401:
                return .unauthorized
            default:
                return .networkError(networkError)
            }
        }
        return .unknown(error)
    }
}
