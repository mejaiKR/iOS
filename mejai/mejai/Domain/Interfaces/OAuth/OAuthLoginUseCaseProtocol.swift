//
//  OAuthLoginUseCaseProtocol.swift
//  mejai
//
//  Created by 지연 on 11/27/24.
//

import Combine

protocol OAuthLoginUseCaseProtocol {
    func login(with provider: OAuthProvider) -> AnyPublisher<OAuthResult, OAuthError>
}
