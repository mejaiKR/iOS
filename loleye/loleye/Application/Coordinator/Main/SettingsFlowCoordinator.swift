//
//  SettingsFlowCoordinator.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

protocol SettingsFlowCoordinatorDelegate: AnyObject {
    func moveToOnboarding()
}

final class SettingsFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var delegate: SettingsFlowCoordinatorDelegate?
    
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
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension SettingsFlowCoordinator: SettingsViewControllerDelegate {
    func moveToOnboarding() {
        delegate?.moveToOnboarding()
    }
}
