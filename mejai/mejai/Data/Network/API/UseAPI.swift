//
//  UseAPI.swift
//  mejai
//
//  Created by 지연 on 12/1/24.
//

import Foundation

enum UserAPI {
    case postLogin(socialId: String, socialType: String)
}

extension UserAPI: TargetType {
    var path: String {
        switch self {
        case .postLogin: "/app/user/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postLogin: .post
        }
    }
    
    var task: Task {
        switch self {
        case let .postLogin(socialId, socialType):
                .requestJSONEncodable(PostLoginRequest(socialId: socialId, socialType: socialType))
        }
    }
}
