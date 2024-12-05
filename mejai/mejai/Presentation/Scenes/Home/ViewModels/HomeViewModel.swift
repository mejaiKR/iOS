//
//  HomeViewModel.swift
//  mejai
//
//  Created by 지연 on 11/5/24.
//

import Combine
import Foundation

enum HomeViewState {
    case loading
    case success
    case error
}

final class HomeViewModel: ViewModel {
    enum Action {
        case fetchSummonerDetail
    }
    
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
        
        static let initialState = State(
            homeViewState: .loading,
            summonerProfileViewModel: SummonerProfileViewModel(
                relationship: "",
                name: "",
                tagLine: "",
                image: nil
            ),
            rankTierCellViewModels: [
                RankTierCellViewModel(cellType: .flex, rankTier: "", image: nil),
                RankTierCellViewModel(cellType: .solo, rankTier: "", image: nil)
            ],
            todayDayLogCellViewModels: [
                TodayDayLogCellViewModel(cellType: .count, data: 0),
                TodayDayLogCellViewModel(cellType: .time, data: 0)
            ],
            todayPlayLogCellViewModels: [],
            weekPlayLogCellViewModels: [
                WeekPlayLogCellViewModel(day: "월", count: 0),
                WeekPlayLogCellViewModel(day: "화", count: 0),
                WeekPlayLogCellViewModel(day: "수", count: 0),
                WeekPlayLogCellViewModel(day: "목", count: 0),
                WeekPlayLogCellViewModel(day: "금", count: 0),
                WeekPlayLogCellViewModel(day: "토", count: 0),
                WeekPlayLogCellViewModel(day: "일", count: 0)
            ]
        )
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    private(set) var state: State
    
    private let getSummonerDetailUseCase: GetSummonerDetailUseCase
    
    // MARK: - Init
    
    init(getSummonerDetailUseCase: GetSummonerDetailUseCase) {
        self.getSummonerDetailUseCase = getSummonerDetailUseCase
        self.state = State.initialState
        
        self.actionSubject
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .fetchSummonerDetail:
            fetchSummonerDetail()
        }
    }
    
    private func fetchSummonerDetail() {
        state.homeViewState.send(.loading)
        
        getSummonerDetailUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    state.homeViewState.send(.success)
                case .failure(let error):
                    state.homeViewState.send(.error)
                    print(error)
                }
            } receiveValue: { [weak self] viewData in
                guard let self = self else { return }
                state.summonerProfileViewModel.send(viewData.profile)
                state.rankTierCellViewModels.send(viewData.rankTiers)
                state.todayDayLogCellViewModels.send(viewData.todayLogs)
                state.todayPlayLogCellViewModels.send(viewData.todayPlayLogs)
                state.weekPlayLogCellViewModels.send(viewData.weekPlayLogs)
            }
            .store(in: &cancellables)
    }
}
