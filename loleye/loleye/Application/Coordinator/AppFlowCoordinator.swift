//
//  AppFlowCoordinator.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import UIKit

final class AppFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    private let appDIContainer: AppDIContainer
    
    init(
        window: UIWindow,
        appDIContainer: AppDIContainer
    ) {
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        if needsOnboarding() {
            showOnboardingFlow()
        } else {
            showMainFlow()
        }
    }
    
    private func needsOnboarding() -> Bool {
        return !UserDataStorage.shared.isLogin
    }
    
    private func showOnboardingFlow() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        let onboardingDIContainer = appDIContainer.makeOnboardingDIContainer()
        
        let onboardingCoordinator = OnboardingFlowCoordinator(
            navigationController: navigationController,
            onboardingDIContainer: onboardingDIContainer
        )
        
        onboardingCoordinator.delegate = self
        store(coordinator: onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    private func showMainFlow() {
        UserDataStorage.shared.isOnboardingCompleted = true
        UserDataStorage.shared.isLogin = true
        print("👩🏻‍💻 온보딩 완료")
        let tabBarController = MainTabBarController()
        window.rootViewController = tabBarController
        
        let mainDIContainer = appDIContainer.makeMainDIContainer()
        
        let mainCoordinator = MainFlowCoordinator(
            tabBarController: tabBarController,
            mainDIContainer: mainDIContainer
        )
        
        store(coordinator: mainCoordinator)
        mainCoordinator.start()
    }
}

extension AppFlowCoordinator: OnboardingFlowCoordinatorDelegate {
    func onboardingFlowDidFinish(_ coordinator: OnboardingFlowCoordinator) {
        free(coordinator: coordinator)
        showMainFlow()
    }
}
