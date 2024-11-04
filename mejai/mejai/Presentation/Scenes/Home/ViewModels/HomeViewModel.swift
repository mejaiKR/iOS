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
        
        init(
            summonerProfileViewModel: SummonerProfileViewModel,
            rankTierCellViewModels: [RankTierCellViewModel]
        ) {
            self.summonerProfileViewModel = .init(summonerProfileViewModel)
            self.rankTierCellViewModels = .init(rankTierCellViewModels)
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
            ]
        )
    }
}
