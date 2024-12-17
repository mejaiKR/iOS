//
//  KakaoLoginService.swift
//  mejai
//
//  Created by 지연 on 11/26/24.
//

import Combine
import Foundation

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

final class KakaoLoginService: OAuthLoginServiceProtocol {
    let provider: OAuthProvider = .kakao
    private var currentSubject: PassthroughSubject<(String, String), OAuthError>?
    
    func login() -> AnyPublisher<(String, String), OAuthError> {
        let subject = PassthroughSubject<(String, String), OAuthError>()
        currentSubject = subject
        
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.handleLoginResult(oauthToken: oauthToken, error: error)
            }
        } else {
            let scopes = ["openid"]
            UserApi.shared.loginWithKakaoAccount(scopes: scopes) { [weak self] (oauthToken, error) in
                self?.handleLoginResult(oauthToken: oauthToken, error: error)
            }
        }
        
        return subject
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.currentSubject = nil
            })
            .eraseToAnyPublisher()
    }
    
    private func handleLoginResult(oauthToken: OAuthToken?, error: Error?) {
        guard let subject = currentSubject else { return }
        
        if let error = error as? SdkError {
            subject.send(completion: .failure(.kakaoError(error)))
        } else if let idToken = oauthToken?.idToken {
            getUserInfo(idToken: idToken)
        } else {
            subject.send(completion: .failure(.unknown(NSError(domain: "unexpected error", code: 0))))
        }
    }
    
    private func getUserInfo(idToken: String) {
        guard let subject = currentSubject else { return }
        print("👩🏻‍💻 idToken:", idToken)
        UserApi.shared.me() { [weak self] (user, error) in
            guard self != nil else {
                subject.send(completion: .failure(.unknown(NSError(domain: "Self is deallocated", code: 0))))
                return
            }
            
            if let error = error as? SdkError {
                subject.send(completion: .failure(.kakaoError(error)))
            } else if let socialID = user?.id {
                subject.send((String(socialID), idToken))
                subject.send(completion: .finished)
            } else {
                subject.send(completion: .failure(.networkError(.invalidResponse)))
            }
        }
    }
}
