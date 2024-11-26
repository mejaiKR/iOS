//
//  SummonerDetailEntity.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

struct SummonerDetailEntity: Decodable {
    let summoner: SummonerInfoEntity
    let today: PlayStatusEntity
    let todayPlayLogs: [PlayLogEntity]
    let thisWeek: [PlayStatusEntity]
    
    func toDomain() -> SummonerDetail {
        return SummonerDetail(
            summoner: summoner.toDomain(),
            today: today.toDomain(),
            todayPlayLogs: todayPlayLogs.map { $0.toDomain() },
            thisWeek: thisWeek.map { $0.toDomain() }
        )
    }
}
