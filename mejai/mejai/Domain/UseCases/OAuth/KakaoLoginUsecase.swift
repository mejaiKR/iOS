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
    private var subject: PassthroughSubject<String, OAuthError> = .init()
    
    func login() -> AnyPublisher<String, OAuthError> {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.handleLoginResult(oauthToken: oauthToken, error: error)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                self?.handleLoginResult(oauthToken: oauthToken, error: error)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    private func handleLoginResult(oauthToken: OAuthToken?, error: Error?) {
        if let error = error as? SdkError {
            subject.send(completion: .failure(.kakaoError(error)))
        } else if oauthToken != nil {
            getUserInfo()
        } else {
            subject.send(completion: .failure(.unknown(NSError(domain: "unexpected error", code: 0))))
        }
    }
    
    private func getUserInfo() {
        UserApi.shared.me() { [weak self] (user, error) in
            guard let self = self else {
                // self가 없는 경우 subject에 에러를 보내고 종료
                let subject = PassthroughSubject<String, OAuthError>()
                subject.send(completion: .failure(.unknown(NSError(domain: "unexpected error", code: 0))))
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
