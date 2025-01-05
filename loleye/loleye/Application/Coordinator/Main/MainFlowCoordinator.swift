//
//  MainFlowCoordinator.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import UIKit

protocol MainFlowCoordinatorDelegate: AnyObject {
    func mainFlowDidFinish(_ coordinator: MainFlowCoordinator)
}

final class MainFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var delegate: MainFlowCoordinatorDelegate?
    
    private let tabBarController: UITabBarController
    private let mainDIContainer: MainDIContainer
    
    init(
        tabBarController: UITabBarController,
        mainDIContainer: MainDIContainer
    ) {
        self.tabBarController = tabBarController
        self.mainDIContainer = mainDIContainer
    }
    
    func start() {
        let homeNavigation = UINavigationController()
        let settingsNavigation = UINavigationController()
        
        let homeCoordinator = HomeFlowCoordinator(
            navigationController: homeNavigation,
            homeDIContainer: mainDIContainer.makeHomeDIContainer()
        )
        
        let settingsCoordinator = SettingsFlowCoordinator(
            navigationController: settingsNavigation,
            settingsDIContainer: mainDIContainer.makeSettingsDIContainer()
        )
        settingsCoordinator.delegate = self
        
        store(coordinator: homeCoordinator)
        store(coordinator: settingsCoordinator)
        
        homeCoordinator.start()
        settingsCoordinator.start()
        
        homeNavigation.tabBarItem = UITabBarItem(
            title: nil,
            image: .homeUnselected,
            selectedImage: .homeSelected
        )
        settingsNavigation.tabBarItem = UITabBarItem(
            title: nil,
            image: .settingsUnselected,
            selectedImage: .settingsSelected
        )
        
        tabBarController.setViewControllers([homeNavigation, settingsNavigation], animated: false)
    }
}

extension MainFlowCoordinator: SettingsFlowCoordinatorDelegate {
    func moveToOnboarding() {
        delegate?.mainFlowDidFinish(self)
    }
}
