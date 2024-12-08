//
//  TodayPlayLogCellViewModel.swift
//  mejai
//
//  Created by 지연 on 11/5/24.
//

import Foundation

struct TodayPlayLogCellViewModel: Hashable {
    let id: UUID
    let startTime: String
    let endTime: String
    let isWin: Bool
    let isFirst: Bool
    let isLast: Bool
    
    init(
        id: UUID = .init(),
        startTime: String,
        endTime: String,
        isWin: Bool,
        isFirst: Bool = false,
        isLast: Bool = false
    ) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.isWin = isWin
        self.isFirst = isFirst
        self.isLast = isLast
    }
}
