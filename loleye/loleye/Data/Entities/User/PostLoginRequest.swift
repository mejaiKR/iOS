//
//  PostLoginRequest.swift
//  mejai
//
//  Created by 지연 on 12/1/24.
//

import Foundation

struct PostLoginRequest: Codable {
    let socialType: String
    let idToken: String
}
