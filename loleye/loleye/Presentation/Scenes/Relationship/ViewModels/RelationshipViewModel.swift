//
//  RelationshipViewModel.swift
//  loleye
//
//  Created by 지연 on 12/8/24.
//

import Combine
import Foundation

final class RelationshipViewModel: ViewModel {
    enum Action {
        case relationDidTap(Relationship)
        case save
    }
    
    struct State {
        var fetchResult = PassthroughSubject<Bool, Never>()
        var isRelationSet = CurrentValueSubject<Bool, Never>(false)
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state: State
    
    private let summonerSearchData: SummonerSearchData
    private let putSummonerUseCase: PutSummonerUseCase
    private var relationship: Relationship?
    
    // MARK: - Init
    
    init(summonerSearchData: SummonerSearchData, putSummonerUseCase: PutSummonerUseCase) {
        self.summonerSearchData = summonerSearchData
        self.putSummonerUseCase = putSummonerUseCase
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
        case let .relationDidTap(relationship):
            relationDidTap(relationship: relationship)
        case .save:
            save()
        }
    }
    
    private func relationDidTap(relationship: Relationship) {
        self.relationship = relationship
        if !state.isRelationSet.value {
            state.isRelationSet.send(true)
        }
    }
    
    private func save() {
        let summonerName = summonerSearchData.summonerName
        let tag = summonerSearchData.tag
        guard let relationship = relationship?.rawValue else { return }
        putSummonerUseCase.execute(
            summonerName: summonerName,
            tag: tag,
            relationship: relationship
        )
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                print("👩🏻‍💻 putSummoner finished")
                self?.state.fetchResult.send(true)
            case .failure(let error):
                print("👩🏻‍💻 putSummoner failed:", error)
                self?.state.fetchResult.send(false)
            }
        } receiveValue: { _ in }
        .store(in: &cancellables)
    }
}
