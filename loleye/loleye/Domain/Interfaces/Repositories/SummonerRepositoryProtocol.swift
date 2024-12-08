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
    ) -> AnyPublisher<GetSummonerSearchResponse, Error>
    func putSummoner(
        summonerName: String,
        tag: String,
        relationship: String
    ) -> AnyPublisher<PutSummonerResponse, Error>
    func getSummonerDetail() -> AnyPublisher<GetSummonerResponse, Error>
}
