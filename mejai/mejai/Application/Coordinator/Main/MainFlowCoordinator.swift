//
//  MainFlowCoordinator.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import UIKit

final class MainFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
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
