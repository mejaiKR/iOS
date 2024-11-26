//
//  AppDIContainer.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import Foundation

final class AppDIContainer {
    private let networkService: NetworkServiceProtocol
    private let summonerRepository: SummonerRepositoryProtocol
    private let getSummonerDetailUseCase: GetSummonerDetailUseCase
    
    init() {
        networkService = NetworkService.shared
        summonerRepository = SummonerRepository(networkService: networkService)
        getSummonerDetailUseCase = GetSummonerDetailUseCase(repository: summonerRepository)
    }
    
    // MARK: - DIContainers of scenes
    
    func makeOnboardingDIContainer() -> OnboardingDIContainer {
        let dependencies = OnboardingDIContainer.Dependencies()
        return OnboardingDIContainer(dependencies: dependencies)
    }
    
    func makeMainDIContainer() -> MainDIContainer {
        let dependencies = MainDIContainer.Dependencies(
            getSummonerDetailUseCase: getSummonerDetailUseCase
        )
        return MainDIContainer(dependencies: dependencies)
    }
}
