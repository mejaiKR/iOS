//
//  SettingsViewModel.swift
//  loleye
//
//  Created by 지연 on 12/15/24.
//

import Combine
import Foundation

final class SettingsViewModel: ViewModel {
    enum Action {
        case otherSummoner
        case logout
        case widhdraw
    }
    
    struct State {
        var isActionDone = PassthroughSubject<Void, Never>()
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state: State
    
    private let keychainService: KeychainServiceProtocol
    private let postDeleteUseCase: PostDeleteUseCase
    
    // MARK: - Init
    
    init(keychainService: KeychainServiceProtocol, postDeleteUseCase: PostDeleteUseCase) {
        self.keychainService = keychainService
        self.postDeleteUseCase = postDeleteUseCase
        self.state = State()
        
        self.actionSubject
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .otherSummoner:
            otherSummoner()
        case .logout:
            logout()
        case .widhdraw:
            withdraw()
        }
    }
    
    private func otherSummoner() {
        UserDataStorage.shared.isOnboardingCompleted = false
        state.isActionDone.send()
    }
    
    private func logout() {
        do {
            try keychainService.clear()
            UserDataStorage.shared.isLogin = false
            state.isActionDone.send()
        } catch {
            print("👩🏻‍💻 logout error")
        }
    }
    
    private func withdraw() {
        postDeleteUseCase.execute()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("👩🏻‍💻 postDelete finished")
                    self?.removeUserData()
                    self?.state.isActionDone.send()
                case .failure(let error):
                    print("👩🏻‍💻 postDelete failed:", error)
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    private func removeUserData() {
        do {
            try keychainService.clear()
            UserDataStorage.shared.isLogin = false
            UserDataStorage.shared.isOnboardingCompleted = false
        } catch {
            print("👩🏻‍💻 withdraw error")
        }
    }
}
