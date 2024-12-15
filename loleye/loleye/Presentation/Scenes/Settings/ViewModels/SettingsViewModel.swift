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
    
    // MARK: - Init
    
    init(keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
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
        case .logout:
            logout()
        case .widhdraw:
            withdraw()
        }
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
        
    }
}
