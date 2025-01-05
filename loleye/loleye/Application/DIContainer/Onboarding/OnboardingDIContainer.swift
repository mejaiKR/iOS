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
        let getSummonerSearchUseCase: GetSummonerSearchUseCase
        let putSummonerUseCase: PutSummonerUseCase
    }

    private var dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - View Models
    
    private func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(loginUseCase: dependencies.loginUseCase)
    }
    
    private func makeSearchSearchViewModel() -> SummonerSearchViewModel {
        return SummonerSearchViewModel(
            getSummonerSearchUseCase: dependencies.getSummonerSearchUseCase
        )
    }
    
    private func makeRelationshipViewModel(
        summonerSearchData: SummonerSearchData
    ) -> RelationshipViewModel {
        return RelationshipViewModel(
            summonerSearchData: summonerSearchData,
            putSummonerUseCase: dependencies.putSummonerUseCase
        )
    }

    // MARK: - View Controllers
    
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController(viewModel: makeLoginViewModel())
    }
    
    func makeSummonerSearchViewController() -> SummonerSearchViewController {
        return SummonerSearchViewController(viewModel: makeSearchSearchViewModel())
    }
    
    func makeRelationshipViewController(
        summonerSearchData: SummonerSearchData
    ) -> RelationshipViewController {
        return RelationshipViewController(
            viewModel: makeRelationshipViewModel(summonerSearchData: summonerSearchData)
        )
    }
}
