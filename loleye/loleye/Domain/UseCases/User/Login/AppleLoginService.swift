//
//  AppleLoginService.swift
//  mejai
//
//  Created by 지연 on 11/26/24.
//

import AuthenticationServices
import Combine
import Foundation

final class AppleLoginService: NSObject, OAuthLoginServiceProtocol {
    let provider: OAuthProvider = .apple
    private var currentSubject: PassthroughSubject<(String, String), OAuthError>?
    
    func login() -> AnyPublisher<(String, String), OAuthError> {
        // 새로운 subject 생성
        let subject = PassthroughSubject<(String, String), OAuthError>()
        currentSubject = subject
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
        // subject가 complete되면 currentSubject 초기화
        return subject
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.currentSubject = nil
            })
            .eraseToAnyPublisher()
    }
}

extension AppleLoginService: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let subject = currentSubject else { return }
        
        guard let appleIDCredential = authorization.credential
                as? ASAuthorizationAppleIDCredential else {
            subject.send(completion: .failure(.unknown(NSError(domain: "unexpected error", code: 0))))
            return
        }
        if let identityToken = appleIDCredential.identityToken,
           let idToken = String(data: identityToken, encoding: .utf8) {
            print("👩🏻‍💻 idToken:", idToken)
            subject.send((appleIDCredential.user, idToken))
            subject.send(completion: .finished)
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        guard let subject = currentSubject else { return }
        
        if let error = error as? ASAuthorizationError {
            switch error.code {
            case .canceled:
                subject.send(completion: .finished)
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
