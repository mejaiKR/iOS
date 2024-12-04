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
    
    func getSummonerDetail(name: String, tag: String) -> AnyPublisher<SummonerDetail, Error> {
        let target = SummonerAPI.getSummoner(summonerName: name, tag: tag)
        return networkService.request(target, responseType: GetSummonerResponse.self)
            .map { $0.toDomain() }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
