//
//  Task.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
    case requestJSONEncodable(Encodable)
}
