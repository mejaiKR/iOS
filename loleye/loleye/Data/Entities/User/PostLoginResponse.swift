//
//  PostLoginResponse.swift
//  mejai
//
//  Created by 지연 on 12/1/24.
//

import Foundation

struct PostLoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
