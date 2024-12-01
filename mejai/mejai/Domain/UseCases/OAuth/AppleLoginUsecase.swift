//
//  AppleLoginUsecase.swift
//  mejai
//
//  Created by 지연 on 11/26/24.
//

import AuthenticationServices
import Combine
import Foundation

final class AppleLoginService: NSObject, OAuthLoginServiceProtocol {
    let provider: OAuthProvider = .apple
    private var subject: PassthroughSubject<String, OAuthError> = .init()
    
    func login() -> AnyPublisher<String, OAuthError> {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
        return subject.eraseToAnyPublisher()
    }
}

extension AppleLoginService: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let appleIDCredential = authorization.credential
                as? ASAuthorizationAppleIDCredential else {
            subject.send(completion: .failure(.unknown(NSError(domain: "unexpected error", code: 0))))
            return
        }
        
        subject.send(appleIDCredential.user)
        subject.send(completion: .finished)
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        if let error = error as? ASAuthorizationError {
            switch error.code {
            case .canceled:
                break
            default:
                subject.send(completion: .failure(.appleError(error)))
            }
        } else {
            subject.send(completion: .failure(.unknown(NSError(domain: "unexpected error", code: 0))))
        }
    }
}

extension AppleLoginService: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(
        for controller: ASAuthorizationController
    ) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow}) else {
            return UIWindow()
        }
        return window
    }
}
