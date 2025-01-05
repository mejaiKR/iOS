//
//  SummonerRepository.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Combine
import Foundation

final class SummonerRepository: SummonerRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getSummonerSearch(
        summonerName: String,
        tag: String
    ) -> AnyPublisher<GetSummonerSearchResponse, Error> {
        let target = SummonerAPI.getSummonerSearch(summonerName: summonerName, tag: tag)
        return networkService.request(target, responseType: GetSummonerSearchResponse.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func putSummoner(
        summonerName: String,
        tag: String,
        relationship: String
    ) -> AnyPublisher<PutSummonerResponse, Error>{
        let summoner = Summoner(
            summonerName: summonerName,
            tag: tag,
            relationship: relationship
        )
        let target = SummonerAPI.putSummoner(summoner: summoner)
        return networkService.request(target, responseType: PutSummonerResponse.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func getSummonerDetail() -> AnyPublisher<GetSummonerResponse, Error> {
        let target = SummonerAPI.getSummoner
        return networkService.request(target, responseType: GetSummonerResponse.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func postSummonerRefresh() -> AnyPublisher<PostSummonerRefreshResponse, Error> {
        let target = SummonerAPI.postSummonerRefresh
        return networkService.request(target, responseType: PostSummonerRefreshResponse.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
