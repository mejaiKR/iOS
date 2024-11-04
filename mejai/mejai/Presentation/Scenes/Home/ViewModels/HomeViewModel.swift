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
        var rankTierCellViewModels: CurrentValueSubject<[RankTierCellViewModel], Never>
        
        init(rankTierCellViewModels: [RankTierCellViewModel]) {
            self.rankTierCellViewModels = .init(rankTierCellViewModels)
        }
    }
    
    var state: State
    
    init() {
        state = State(
            rankTierCellViewModels: [
                RankTierCellViewModel(cellType: .flex, rankTier: "PLATINUM II", image: nil),
                RankTierCellViewModel(cellType: .solo, rankTier: "UNRANKED I", image: nil)
            ]
        )
    }
}
