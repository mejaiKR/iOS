//
//  PutSummonerUseCase.swift
//  loleye
//
//  Created by 지연 on 12/8/24.
//

import Combine
import Foundation

final class PutSummonerUseCase {
    private let repository: SummonerRepositoryProtocol
    
    init(repository: SummonerRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(
        summonerName: String,
        tag: String,
        relationship: String
    ) -> AnyPublisher<Void, Error> {
        repository.putSummoner(summonerName: summonerName, tag: tag, relationship: relationship)
            .map { response in
                print("👩🏻‍💻 PutSummonerUseCase response:", response)
            }
            .eraseToAnyPublisher()
    }
}
