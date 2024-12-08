//
//  SummonerRepositoryProtocol.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Combine
import Foundation

protocol SummonerRepositoryProtocol {
    func getSummonerSearch(
        summonerName: String,
        tag: String
    ) -> AnyPublisher<SummonerSearchData, Error>
    func getSummonerDetail() -> AnyPublisher<SummonerDetail, Error>
}
