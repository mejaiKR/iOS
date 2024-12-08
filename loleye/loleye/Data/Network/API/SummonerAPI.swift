//
//  SummonerAPI.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

enum SummonerAPI {
    case getSummonerSearch(summonerName: String, tag: String)
    case getSummoner
}

extension SummonerAPI: TargetType {
    var path: String {
        switch self {
        case .getSummonerSearch:    "/app/watch/summoner/search"
        case .getSummoner:          "/app/watch/summoner"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSummonerSearch, .getSummoner: .get
        }
    }
    
    var task: Task {
        switch self {
        case let .getSummonerSearch(summonerName, tag):
                .requestParameters(
                    parameters: ["summonerName": summonerName, "tag": tag],
                    encoding: .urlEncoding
                )
        case .getSummoner:
                .requestPlain
        }
    }
}
