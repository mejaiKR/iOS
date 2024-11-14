//
//  SummonerAPI.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

enum SummonerAPI {
    case getSummoner(summonerName: String, tag: String)
}

extension SummonerAPI: TargetType {
    var path: String {
        switch self {
        case .getSummoner: "/app/watch/summoner"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSummoner: .get
        }
    }
    
    var task: Task {
        switch self {
        case let .getSummoner(summonerName, tag):
                .requestParameters(
                    parameters: ["summonerName": summonerName, "tag": tag],
                    encoding: .urlEncoding
                )
        }
    }
}
