//
//  KakaoLoginUsecase.swift
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
    private var currentSubject: PassthroughSubject<String, OAuthError>?
    
    func login() -> AnyPublisher<String, OAuthError> {
        let subject = PassthroughSubject<String, OAuthError>()
        currentSubject = subject
        
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.handleLoginResult(oauthToken: oauthToken, error: error)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
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
        } else if oauthToken != nil {
            getUserInfo()
        } else {
            subject.send(completion: .failure(.unknown(NSError(domain: "unexpected error", code: 0))))
        }
    }
    
    private func getUserInfo() {
        guard let subject = currentSubject else { return }
        
        UserApi.shared.me() { [weak self] (user, error) in
            guard self != nil else {
                subject.send(completion: .failure(.unknown(NSError(domain: "Self is deallocated", code: 0))))
                return
            }
            
            if let error = error as? SdkError {
                subject.send(completion: .failure(.kakaoError(error)))
            } else if let socialID = user?.id {
                subject.send(String(socialID))
                subject.send(completion: .finished)
            } else {
                subject.send(completion: .failure(.networkError(.invalidResponse)))
            }
        }
    }
}
