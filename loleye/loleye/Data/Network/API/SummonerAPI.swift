//
//  SummonerAPI.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

enum SummonerAPI {
    case getSummonerSearch(summonerName: String, tag: String)
    case putSummoner(summoner: Summoner)
    case getSummoner
}

extension SummonerAPI: TargetType {
    var path: String {
        switch self {
        case .getSummonerSearch:            "/app/watch/summoner/search"
        case .putSummoner, .getSummoner:    "/app/watch/summoner"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSummonerSearch, .getSummoner: .get
        case .putSummoner: .put
        }
    }
    
    var task: Task {
        switch self {
        case let .getSummonerSearch(summonerName, tag):
                .requestParameters(
                    parameters: ["summonerName": summonerName, "tag": tag],
                    encoding: .urlEncoding
                )
        case let .putSummoner(summoner):
                .requestJSONEncodable(summoner)
        case .getSummoner:
                .requestPlain
        }
    }
}
