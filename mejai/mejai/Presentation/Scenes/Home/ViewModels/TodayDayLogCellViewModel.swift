//
//  TodayDayLogCellViewModel.swift
//  mejai
//
//  Created by 지연 on 11/5/24.
//

import Foundation

enum TodayDayLogCellType: String {
    case count = "횟수"
    case time = "시간(분)"
}

struct TodayDayLogCellViewModel: Hashable {
    let cellType: TodayDayLogCellType
    let data: String
}
