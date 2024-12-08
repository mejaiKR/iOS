//
//  SettingsFlowCoordinator.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

final class SettingsFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let settingsDIContainer: SettingsDIContainer
    
    init(
        navigationController: UINavigationController,
        settingsDIContainer: SettingsDIContainer
    ) {
        self.navigationController = navigationController
        self.settingsDIContainer = settingsDIContainer
    }
    
    func start() {
        showSettingsViewController()
    }
    
    private func showSettingsViewController() {
        let viewController = settingsDIContainer.makeSettingsViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
