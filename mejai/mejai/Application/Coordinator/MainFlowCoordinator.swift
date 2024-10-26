//
//  MainFlowCoordinator.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import UIKit

//final class MainFlowCoordinator: Coordinator {
//    var childCoordinators: [Coordinator] = []
//    
//    private let tabBarController: UITabBarController
//    private let mainDIContainer: MainDIContainer
//    
//    init(
//        tabBarController: UITabBarController,
//        mainDIContainer: MainDIContainer
//    ) {
//        self.tabBarController = tabBarController
//        self.mainDIContainer = mainDIContainer
//    }
//    
//    func start() {
//        let homeNavigation = UINavigationController()
//        let settingsNavigation = UINavigationController()
//        
//        let homeCoordinator = HomeFlowCoordinator(
//            navigationController: homeNavigation,
//            homeDIContainer: mainDIContainer.makeHomeDIContainer()
//        )
//        
//        let settingsCoordinator = SettingsFlowCoordinator(
//            navigationController: settingsNavigation,
//            settingsDIContainer: mainDIContainer.makeSettingsDIContainer()
//        )
//        
//        // Store child coordinators
//        store(coordinator: homeCoordinator)
//        store(coordinator: settingsCoordinator)
//        
//        // Start each flow
//        homeCoordinator.start()
//        settingsCoordinator.start()
//        
//        // Setup TabBar
//        homeNavigation.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
//        settingsNavigation.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
//        
//        tabBarController.setViewControllers(
//            [homeNavigation, profileNavigation, settingsNavigation],
//            animated: false
//        )
//    }
//}
