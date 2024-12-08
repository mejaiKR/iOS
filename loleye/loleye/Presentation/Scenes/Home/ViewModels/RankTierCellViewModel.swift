//
//  RankTierCellViewModel.swift
//  mejai
//
//  Created by 지연 on 11/5/24.
//

import Foundation

enum RankTierCellType: String {
    case flex = "자유 랭크"
    case solo = "솔로 랭크"
}

struct RankTierCellViewModel: Hashable {
    let cellType: RankTierCellType
    let rankTier: String
    let image: String?
}
