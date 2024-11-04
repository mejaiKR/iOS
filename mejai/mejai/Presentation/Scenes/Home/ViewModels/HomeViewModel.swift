//
//  HomeViewModel.swift
//  mejai
//
//  Created by 지연 on 11/5/24.
//

import Combine
import Foundation

enum HomeViewState {
    case success
    case error
}

final class HomeViewModel {
    struct State {
        var homeViewState: CurrentValueSubject<HomeViewState, Never>
        var summonerProfileViewModel: CurrentValueSubject<SummonerProfileViewModel, Never>
        var rankTierCellViewModels: CurrentValueSubject<[RankTierCellViewModel], Never>
        var todayDayLogCellViewModels: CurrentValueSubject<[TodayDayLogCellViewModel], Never>
        var todayPlayLogCellViewModels: CurrentValueSubject<[TodayPlayLogCellViewModel], Never>
        var weekPlayLogCellViewModels: CurrentValueSubject<[WeekPlayLogCellViewModel], Never>
        
        init(
            homeViewState: HomeViewState,
            summonerProfileViewModel: SummonerProfileViewModel,
            rankTierCellViewModels: [RankTierCellViewModel],
            todayDayLogCellViewModels: [TodayDayLogCellViewModel],
            todayPlayLogCellViewModels: [TodayPlayLogCellViewModel],
            weekPlayLogCellViewModels: [WeekPlayLogCellViewModel]
        ) {
            self.homeViewState = .init(homeViewState)
            self.summonerProfileViewModel = .init(summonerProfileViewModel)
            self.rankTierCellViewModels = .init(rankTierCellViewModels)
            self.todayDayLogCellViewModels = .init(todayDayLogCellViewModels)
            self.todayPlayLogCellViewModels = .init(todayPlayLogCellViewModels)
            self.weekPlayLogCellViewModels = .init(weekPlayLogCellViewModels)
        }
    }
    
    var state: State
    
    init() {
        state = State(
            homeViewState: .error,
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
                TodayDayLogCellViewModel(cellType: .count, data: 42),
                TodayDayLogCellViewModel(cellType: .time, data: 4242)
            ],
            todayPlayLogCellViewModels: [
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: true, isFirst: true),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: false),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: false),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: false),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: false),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: false),
                TodayPlayLogCellViewModel(startTime: "시작", endTime: "끝", isWin: true, isLast: true)
            ],
            weekPlayLogCellViewModels: [
                WeekPlayLogCellViewModel(day: "월", count: 0),
                WeekPlayLogCellViewModel(day: "화", count: 1),
                WeekPlayLogCellViewModel(day: "수", count: 2),
                WeekPlayLogCellViewModel(day: "목", count: 3),
                WeekPlayLogCellViewModel(day: "금", count: 4),
                WeekPlayLogCellViewModel(day: "토", count: 5),
                WeekPlayLogCellViewModel(day: "일", count: 6),
            ]
        )
    }
}
