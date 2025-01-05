//
//  PostRefreshResponse.swift
//  mejai
//
//  Created by 지연 on 12/4/24.
//

import Foundation

struct PostRefreshResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
