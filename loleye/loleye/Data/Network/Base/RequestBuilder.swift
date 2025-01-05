//
//  RequestBuilder.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

struct RequestBuilder {
    static func buildURLRequest(from target: TargetType, _ accessToken: String?) -> URLRequest? {
        var components = URLComponents(
            url: target.baseURL.appendingPathComponent(target.path),
            resolvingAgainstBaseURL: true
        )
        
        if case let .requestParameters(parameters, encoding) = target.task {
            switch encoding {
            case .urlEncoding:
                components?.queryItems = parameters.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
            case .jsonEncoding:
                break
            }
        }
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        
        // AccessToken이 nil이 아니면 Authorization 헤더에 추가
        if let token = accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch target.task {
        case let .requestParameters(parameters, encoding):
            switch encoding {
            case .urlEncoding:
                break
            case .jsonEncoding:
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            }
        case let .requestJSONEncodable(encodable):
            request.httpBody = try? JSONEncoder().encode(encodable)
        default:
            break
        }
        
        return request
    }
}
