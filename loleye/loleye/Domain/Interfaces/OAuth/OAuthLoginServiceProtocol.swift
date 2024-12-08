//
//  OAuthLoginServiceProtocol.swift
//  mejai
//
//  Created by 지연 on 11/27/24.
//

import Combine

protocol OAuthLoginServiceProtocol {
    var provider: OAuthProvider { get }
    func login() -> AnyPublisher<String, OAuthError>
}
