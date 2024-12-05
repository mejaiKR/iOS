//
//  SummonerSearchResponse.swift
//  mejai
//
//  Created by 지연 on 12/5/24.
//

import Foundation

struct SummonerSearchResponse: Decodable {
    let summonerName: String
    let tag: String
    let profileIcon: String
    let soloRankTier: String
    let soloRankIconUrl: String
    let flexRankTier: String
    let flexRankIconUrl: String
}
