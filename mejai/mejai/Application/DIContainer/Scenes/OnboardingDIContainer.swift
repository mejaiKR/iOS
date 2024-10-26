//
//  OnboardingDIContainer.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import Foundation

final class OnboardingDIContainer {
    struct Dependencies {}

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - View Controllers
    
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController()
    }
    
    func makeSummonerSearchViewController() -> SummonerSearchViewController {
        return SummonerSearchViewController()
    }
    
    func makeRelationshipViewController() -> RelationshipViewController {
        return RelationshipViewController()
    }
}
