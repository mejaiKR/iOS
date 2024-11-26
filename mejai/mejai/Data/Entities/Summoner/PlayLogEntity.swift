//
//  PlayLogEntity.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

struct PlayLogEntity: Decodable {
    let startTime: String
    let endTime: String
    let win: Bool
    
    func toDomain() -> PlayLog {
        return PlayLog(
            startTime: startTime,
            endTime: endTime,
            win: win
        )
    }
}
