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
        case fetchSummoner
        case refresh
    }
    
    struct State {
        var homeViewState: CurrentValueSubject<HomeViewState, Never>
        var lastUpated = PassthroughSubject<String, Never>()
        var summonerProfileViewModel: CurrentValueSubject<SummonerProfileViewModel, Never>
        var rankTierCellViewModels: CurrentValueSubject<[RankTierCellViewModel], Never>
        var todayDayLogCellViewModels: CurrentValueSubject<[TodayDayLogCellViewModel], Never>
        var todayPlayLogCellViewModels: CurrentValueSubject<[TodayPlayLogCellViewModel], Never>
        var weekPlayLogCellViewModels: CurrentValueSubject<[WeekPlayLogCellViewModel], Never>
        var refreshLimit = PassthroughSubject<Void, Never>()
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    private(set) var state: State
    
    private let getSummonerDetailUseCase: GetSummonerDetailUseCase
    private let postSummonerRefreshUseCase: PostSummonerRefreshUseCase
    
    // MARK: - Init
    
    init(
        getSummonerDetailUseCase: GetSummonerDetailUseCase,
        postSummonerRefreshUseCase: PostSummonerRefreshUseCase
    ) {
        self.getSummonerDetailUseCase = getSummonerDetailUseCase
        self.postSummonerRefreshUseCase = postSummonerRefreshUseCase
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
        case .fetchSummoner:
            refreshAndFetchDetails(isRefresh: false)
        case .refresh:
            refreshAndFetchDetails(isRefresh: true)
        }
    }
    
    private func refreshAndFetchDetails(isRefresh: Bool) {
        state.homeViewState.send(.loading)
        
        postSummonerRefreshUseCase.execute()
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    print("👩🏻‍💻 postSummonerRefresh finished")
                    fetchSummonerDetails()
                case .failure(let error):
                    print("👩🏻‍💻 postSummonerRefresh failed:", error)
                    if case NetworkError.unknown(NetworkError.clientError(statusCode: 429)) = error {
                        fetchSummonerDetails()
                        if isRefresh {
                            state.refreshLimit.send()
                        }
                    } else {
                        state.homeViewState.send(.error)
                    }
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    private func fetchSummonerDetails() {
        getSummonerDetailUseCase.execute()
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    print("👩🏻‍💻 getSummonerDetail finished")
                    state.homeViewState.send(.success)
                case .failure(let error):
                    print("👩🏻‍💻 getSummonerDetail failed:", error)
                    state.homeViewState.send(.error)
                    print(error)
                }
            } receiveValue: { [weak self] viewData in
                guard let self = self else { return }
                if let time = extractTime(from: viewData.lastUpdatedWatchSummoner) {
                    state.lastUpated.send("최근 업데이트: \(time)")
                }
                state.summonerProfileViewModel.send(viewData.profile)
                state.rankTierCellViewModels.send(viewData.rankTiers)
                state.todayDayLogCellViewModels.send(viewData.todayLogs)
                state.todayPlayLogCellViewModels.send(viewData.todayPlayLogs)
                state.weekPlayLogCellViewModels.send(viewData.weekPlayLogs)
            }
            .store(in: &cancellables)
    }
    
    private func extractTime(from timestamp: String) -> String? {
        // DateFormatter 설정
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS" // 입력 형식
        
        // String -> Date 변환
        guard let date = formatter.date(from: timestamp) else {
            return nil
        }
        
        // 필요한 시간 형식으로 변환
        formatter.dateFormat = "HH:mm" // 출력 형식
        return formatter.string(from: date)
    }
}

private extension HomeViewModel.State {
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
    
    static let initialState = HomeViewModel.State(
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
