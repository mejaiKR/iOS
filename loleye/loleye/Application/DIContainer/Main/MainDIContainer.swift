//
//  MainDIContainer.swift
//  mejai
//
//  Created by 지연 on 10/28/24.
//

import Foundation

final class MainDIContainer {
    struct Dependencies {
        let keychainService: KeychainServiceProtocol
        let getSummonerDetailUseCase: GetSummonerDetailUseCase
        let postSummonerRefreshUseCase: PostSummonerRefreshUseCase
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - DI Containers
    
    func makeHomeDIContainer() -> HomeDIContainer {
        let dependencies = HomeDIContainer.Dependencies(
            getSummonerDetailUseCase: dependencies.getSummonerDetailUseCase,
            postSummonerRefreshUseCase: dependencies.postSummonerRefreshUseCase
        )
        return HomeDIContainer(dependencies: dependencies)
    }
    
    func makeSettingsDIContainer() -> SettingsDIContainer {
        let dependencies = SettingsDIContainer.Dependencies(
            keychainService: dependencies.keychainService
        )
        return SettingsDIContainer(dependencies: dependencies)
    }
}
