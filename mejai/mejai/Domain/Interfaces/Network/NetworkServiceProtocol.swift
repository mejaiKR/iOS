//
//  NetworkServiceProtocol.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Combine
import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        _ target: TargetType,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError>
}
