//
//  AppDIContainer.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import Foundation

final class AppDIContainer {
    private let keychainService: KeychainServiceProtocol
    private let networkService: NetworkServiceProtocol
    private let loginUseCase: OAuthLoginUseCaseProtocol
    private let summonerRepository: SummonerRepositoryProtocol
    private let getSummonerSearchUseCase: GetSummonerSearchUseCase
    private let putSummonerUseCase: PutSummonerUseCase
    private let getSummonerDetailUseCase: GetSummonerDetailUseCase
    private let postSummonerRefreshUseCase: PostSummonerRefreshUseCase
    private let postDeleteUseCase: PostDeleteUseCase
    
    init() {
        keychainService = KeychainService()
        networkService = NetworkService(keychainService: keychainService)
        loginUseCase = OAuthUseCase(
            loginServices: [AppleLoginService(), KakaoLoginService()],
            networkService: networkService,
            keychainService: keychainService
        )
        summonerRepository = SummonerRepository(networkService: networkService)
        getSummonerSearchUseCase = GetSummonerSearchUseCase(repository: summonerRepository)
        putSummonerUseCase = PutSummonerUseCase(repository: summonerRepository)
        getSummonerDetailUseCase = GetSummonerDetailUseCase(repository: summonerRepository)
        postSummonerRefreshUseCase = PostSummonerRefreshUseCase(repository: summonerRepository)
        postDeleteUseCase = PostDeleteUseCase(networkService: networkService)
        
        if let accessToken = try? keychainService.retrieve(for: .accessToken) {
            print("👩🏻‍💻 access token:", accessToken)
        }
    }
    
    // MARK: - DIContainers of scenes
    
    func makeOnboardingDIContainer() -> OnboardingDIContainer {
        let dependencies = OnboardingDIContainer.Dependencies(
            loginUseCase: loginUseCase,
            getSummonerSearchUseCase: getSummonerSearchUseCase,
            putSummonerUseCase: putSummonerUseCase
        )
        return OnboardingDIContainer(dependencies: dependencies)
    }
    
    func makeMainDIContainer() -> MainDIContainer {
        let dependencies = MainDIContainer.Dependencies(
            keychainService: keychainService,
            getSummonerDetailUseCase: getSummonerDetailUseCase,
            postSummonerRefreshUseCase: postSummonerRefreshUseCase,
            postDeleteUseCase: postDeleteUseCase
        )
        return MainDIContainer(dependencies: dependencies)
    }
}
