//
//  OnboardingFlowCoordinator.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import UIKit

protocol OnboardingFlowCoordinatorDelegate: AnyObject {
    func onboardingFlowDidFinish(_ coordinator: OnboardingFlowCoordinator)
}

final class OnboardingFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var delegate: OnboardingFlowCoordinatorDelegate?
    
    private let navigationController: UINavigationController
    private let onboardingDIContainer: OnboardingDIContainer
    
    init(
        navigationController: UINavigationController,
        onboardingDIContainer: OnboardingDIContainer
    ) {
        self.navigationController = navigationController
        self.onboardingDIContainer = onboardingDIContainer
    }
    
    func start() {
        showLoginViewController()
    }
    
    private func showLoginViewController() {
        let viewController = onboardingDIContainer.makeLoginViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showSummonerSearchViewController() {
        let viewController = onboardingDIContainer.makeSummonerSearchViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showRelationshipViewController() {
        let viewController = onboardingDIContainer.makeRelationshipViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension OnboardingFlowCoordinator: LoginViewControllerDelegate {
    func loginViewControllerDidFinish() {
        showSummonerSearchViewController()
    }
}

extension OnboardingFlowCoordinator: SummonerSearchViewControllerDelegate {
    func summonerSearchViewControllerDidFinish() {
        showRelationshipViewController()
    }
}

extension OnboardingFlowCoordinator: RelationshipViewControllerDelegate {
    func relationshipViewControllerDidFinish() {
        delegate?.onboardingFlowDidFinish(self)
    }
}
