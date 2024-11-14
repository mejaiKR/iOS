//
//  HomeViewData.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

struct HomeViewData {
    let profile: SummonerProfileViewModel
    let rankTiers: [RankTierCellViewModel]
    let todayLogs: [TodayDayLogCellViewModel]
    let todayPlayLogs: [TodayPlayLogCellViewModel]
    let weekPlayLogs: [WeekPlayLogCellViewModel]
}
