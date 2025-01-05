//
//  UserAPI.swift
//  mejai
//
//  Created by 지연 on 12/1/24.
//

import Foundation

enum UserAPI {
    case postLogin(socialType: String, idToken: String)
    case postRefresh(refreshToken: String)
    case postDelete
}

extension UserAPI: TargetType {
    var path: String {
        switch self {
        case .postLogin:    "/app/user/login"
        case .postRefresh:  "/app/user/refresh"
        case .postDelete:   "/app/user/delete"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postLogin, .postRefresh, .postDelete: .post
        }
    }
    
    var task: Task {
        switch self {
        case let .postLogin(socialType, idToken):
                .requestJSONEncodable(
                    PostLoginRequest(socialType: socialType, idToken: idToken)
                )
        case let .postRefresh(refreshToken):
                .requestJSONEncodable(PostRefreshRequest(refreshToken: refreshToken))
        case .postDelete:
                .requestPlain
        }
    }
}
