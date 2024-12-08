//
//  LoginViewModel.swift
//  mejai
//
//  Created by 지연 on 12/1/24.
//

import Combine
import Foundation

final class LoginViewModel: ViewModel {
    enum Action {
        case loginButtonDidTap(OAuthProvider)
    }
    
    struct State {
        var loginResult = PassthroughSubject<OAuthResult, Never>()
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    private(set) var state: State
    
    private let loginUseCase: OAuthLoginUseCaseProtocol
    
    // MARK: - Init
    
    init(loginUseCase: OAuthLoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
        self.state = State()
        setupActionBindings()
    }
    
    // MARK: - Handle Action Methods
    
    private func setupActionBindings() {
        actionSubject.sink { [weak self] action in
            switch action {
            case .loginButtonDidTap(let provider):
                self?.login(provider: provider)
            }
        }
        .store(in: &cancellables)
    }
    
    private func login(provider: OAuthProvider) {
        loginUseCase.login(with: provider)
            .sink { [weak self] result in
                self?.state.loginResult.send(result)
            }
            .store(in: &cancellables)
    }
}
