//
//  PlayStatusEntity.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

struct PlayStatusEntity: Decodable {
    let playCount: Int
    let playTime: Int
    
    func toDomain() -> PlayStatus {
        return PlayStatus(
            playCount: playCount,
            playTime: playTime
        )
    }
}
