//
//  PostSummonerRefreshUseCase.swift
//  loleye
//
//  Created by 지연 on 12/8/24.
//

import Combine
import Foundation

final class PostSummonerRefreshUseCase {
    private let repository: SummonerRepositoryProtocol
    
    init(repository: SummonerRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<Void, Error> {
        repository.postSummonerRefresh()
            .map { response in
                print("👩🏻‍💻 PostSummonerRefreshUseCase response:", response)
            }
            .eraseToAnyPublisher()
    }
}
