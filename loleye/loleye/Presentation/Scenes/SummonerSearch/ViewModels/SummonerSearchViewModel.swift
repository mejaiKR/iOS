//
//  SummonerSearchViewModel.swift
//  loleye
//
//  Created by 지연 on 12/5/24.
//

import Combine
import Foundation

enum SummonerSearchViewState {
    case initial
    case success
    case failure
    case invalidInput
}

final class SummonerSearchViewModel: ViewModel {
    enum Action {
        case search(String)
        case resultViewDidTap
        case textFieldDidClear
    }
    
    struct State {
        var summonerSearchViewState = CurrentValueSubject<SummonerSearchViewState, Never>(.initial)
        var summonerSearchData = PassthroughSubject<SummonerSearchData, Never>()
        var isSummonerSet = CurrentValueSubject<Bool, Never>(false)
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    private(set) var state: State
    
    private let getSummonerSearchUseCase: GetSummonerSearchUseCase
    private var lastSearchedSummonerSerchData: SummonerSearchData? // 가장 최근에 검색한 소환사 데이터
    var summonerSearchData: SummonerSearchData? // 사용자가 선택한 소환사 데이터
    
    // MARK: - Init
    
    init(getSummonerSearchUseCase: GetSummonerSearchUseCase) {
        self.getSummonerSearchUseCase = getSummonerSearchUseCase
        self.state = State()
        
        self.actionSubject
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case let .search(text):
            search(text)
        case .resultViewDidTap:
            updateSummonerSearchDataState()
        case .textFieldDidClear:
            textFieldDidClear()
        }
    }
    
    private func search(_ text: String) {
        let components = text.split(separator: "#")
        guard components.count == 2 else {
            state.summonerSearchViewState.send(.invalidInput)
            return
        }
        
        let summonerName = String(components[0])
        let tagLine = String(components[1])
        
        getSummonerSearchUseCase.execute(summonerName: summonerName, tag: tagLine)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("👩🏻‍💻 getSummonerSearch finished")
                    self?.state.summonerSearchViewState.send(.success)
                case .failure(let error):
                    print("👩🏻‍💻 getSummonerSearch failed:", error)
                    self?.state.summonerSearchViewState.send(.failure)
                }
            } receiveValue: { [weak self] data in
                self?.state.summonerSearchData.send(data)
                self?.lastSearchedSummonerSerchData = data
            }
            .store(in: &cancellables)
    }
    
    private func updateSummonerSearchDataState() {
        state.isSummonerSet.send(!state.isSummonerSet.value)
        summonerSearchData = lastSearchedSummonerSerchData
    }
    
    private func textFieldDidClear() {
        state.summonerSearchViewState.send(.initial)
    }
}
