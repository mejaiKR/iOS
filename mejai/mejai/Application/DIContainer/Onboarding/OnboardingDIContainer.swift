//
//  OnboardingDIContainer.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import Foundation

final class OnboardingDIContainer {
    struct Dependencies {
        let loginUseCase: OAuthLoginUseCaseProtocol
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - View Models
    
    private func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(loginUseCase: dependencies.loginUseCase)
    }

    // MARK: - View Controllers
    
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController(viewModel: makeLoginViewModel())
    }
    
    func makeSummonerSearchViewController() -> SummonerSearchViewController {
        return SummonerSearchViewController()
    }
    
    func makeRelationshipViewController() -> RelationshipViewController {
        return RelationshipViewController()
    }
}
