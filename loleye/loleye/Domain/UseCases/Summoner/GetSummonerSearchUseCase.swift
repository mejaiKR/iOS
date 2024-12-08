//
//  GetSummonerSearchUseCase.swift
//  loleye
//
//  Created by 지연 on 12/5/24.
//

import Combine
import Foundation

final class GetSummonerSearchUseCase {
    private let repository: SummonerRepositoryProtocol
    
    init(repository: SummonerRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(summonerName: String, tag: String) -> AnyPublisher<SummonerSearchData, Error> {
        repository.getSummonerSearch(summonerName: summonerName, tag: tag)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
