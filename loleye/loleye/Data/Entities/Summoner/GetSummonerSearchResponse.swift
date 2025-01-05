//
//  GetSummonerSearchResponse.swift
//  mejai
//
//  Created by 지연 on 12/5/24.
//

import Foundation

struct GetSummonerSearchResponse: Decodable {
    let summonerName: String
    let tag: String
    let profileIcon: String
    let soloRankTier: String
    let flexRankTier: String
    
    func toDomain() -> SummonerSearchData {
        return SummonerSearchData(
            summonerName: summonerName,
            tag: tag,
            profileIcon: profileIcon,
            soloRankTier: soloRankTier,
            flexRankTier: flexRankTier
        )
    }
}
