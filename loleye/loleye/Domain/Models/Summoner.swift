//
//  PutSummonerRequest.swift
//  loleye
//
//  Created by 지연 on 12/8/24.
//

import Foundation

struct Summoner: Encodable {
    let summonerName: String
    let tag: String
    let relationship: String
}
