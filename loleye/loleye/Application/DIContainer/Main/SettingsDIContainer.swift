//
//  SettingsDIContainer.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

final class SettingsDIContainer {
    struct Dependencies {
        let keychainService: KeychainServiceProtocol
        let postDeleteUseCase: PostDeleteUseCase
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - View Models
    
    private func makeSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(
            keychainService: dependencies.keychainService,
            postDeleteUseCase: dependencies.postDeleteUseCase
        )
    }
    
    // MARK: - View Controllers
    
    func makeSettingsViewController() -> SettingsViewController {
        return SettingsViewController(viewModel: makeSettingsViewModel())
    }
}
