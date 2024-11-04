//
//  HomeViewModel.swift
//  mejai
//
//  Created by 지연 on 11/5/24.
//

import Combine
import Foundation

final class HomeViewModel {
    struct State {
        var summonerProfileViewModel: CurrentValueSubject<SummonerProfileViewModel, Never>
        var rankTierCellViewModels: CurrentValueSubject<[RankTierCellViewModel], Never>
        var todayDayLogCellViewModels: CurrentValueSubject<[TodayDayLogCellViewModel], Never>
        var todayPlayLogCellViewModels: CurrentValueSubject<[TodayPlayLogCellViewModel], Never>
        
        init(
            summonerProfileViewModel: SummonerProfileViewModel,
            rankTierCellViewModels: [RankTierCellViewModel],
            todayDayLogCellViewModels: [TodayDayLogCellViewModel],
            todayPlayLogCellViewModels: [TodayPlayLogCellViewModel]
        ) {
            self.summonerProfileViewModel = .init(summonerProfileViewModel)
            self.rankTierCellViewModels = .init(rankTierCellViewModels)
            self.todayDayLogCellViewModels = .init(todayDayLogCellViewModels)
            self.todayPlayLogCellViewModels = .init(todayPlayLogCellViewModels)
        }
    }
    
    var state: State
    
    init() {
        state = State(
            summonerProfileViewModel:
                SummonerProfileViewModel(
                    relationship: "관계",
                    name: "소환사이름",
                    tagLine: "태그라인",
                    image: nil
                ),
            rankTierCellViewModels: [
                RankTierCellViewModel(cellType: .flex, rankTier: "자유 랭크 티어", image: nil),
                RankTierCellViewModel(cellType: .solo, rankTier: "솔로 랭크 티어", image: nil)
            ],
            todayDayLogCellViewModels: [
                TodayDayLogCellViewModel(cellType: .count, data: "횟수"),
                TodayDayLogCellViewModel(cellType: .time, data: "시간")
            ],
            todayPlayLogCellViewModels: [
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: true, isFirst: true),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: false),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: false),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: false),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: false),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: false),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: true, isLast: true)
            ]
        )
    }
}
