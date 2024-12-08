//
//  TargetType.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

// API 정의를 위한 프로토콜
protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}

extension TargetType {
    var baseURL: URL {
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "MEJAI_URL") as? String,
           let decodedUrlString = urlString.removingPercentEncoding,
           let url = URL(string: decodedUrlString) {
            return url
        } else {
            fatalError("MEJAI_URL 생성 실패")
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
}
