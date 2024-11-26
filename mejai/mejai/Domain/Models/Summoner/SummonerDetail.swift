//
//  SummonerDetail.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

struct SummonerDetail {
    let summoner: SummonerInfo
    let today: PlayStatus
    let todayPlayLogs: [PlayLog]
    let thisWeek: [PlayStatus]
}
