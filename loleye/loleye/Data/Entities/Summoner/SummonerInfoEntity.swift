//
//  SummonerInfoEntity.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

struct SummonerInfoEntity: Decodable {
    let summonerName: String
    let tag: String
    let profileIcon: String
    let relationship: String
    let soloRankTier: String
    let soloRankIconUrl: String
    let flexRankTier: String
    let flexRankIconUrl: String
    let lastUpdatedWatchSummoner: String
    
    func toDomain() -> SummonerInfo {
        return SummonerInfo(
            summonerName: summonerName,
            tag: tag,
            profileIcon: profileIcon,
            relationship: Relationship(rawValue: relationship) ?? .friend,
            soloRankTier: soloRankTier,
            soloRankIconUrl: soloRankIconUrl,
            flexRankTier: flexRankTier,
            flexRankIconUrl: flexRankIconUrl,
            lastUpdatedWatchSummoner: lastUpdatedWatchSummoner
        )
    }
}
