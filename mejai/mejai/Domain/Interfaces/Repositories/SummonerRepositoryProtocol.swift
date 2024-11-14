//
//  SummonerRepositoryProtocol.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Combine
import Foundation

protocol SummonerRepositoryProtocol {
    func getSummonerDetail(name: String, tag: String) -> AnyPublisher<SummonerDetail, Error>
}
