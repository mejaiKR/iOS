//
//  HomeFlowCoordinator.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import UIKit

final class HomeFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let homeDIContainer: HomeDIContainer
    
    init(
        navigationController: UINavigationController,
        homeDIContainer: HomeDIContainer
    ) {
        self.navigationController = navigationController
        self.homeDIContainer = homeDIContainer
    }
    
    func start() {
        showHomeViewController()
    }
    
    private func showHomeViewController() {
        let viewController = homeDIContainer.makeHomeViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
