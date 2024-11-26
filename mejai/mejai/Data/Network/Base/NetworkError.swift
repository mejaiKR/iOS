//
//  NetworkError.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case decodingError
    case unauthorized
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case unknown(Error)
}
