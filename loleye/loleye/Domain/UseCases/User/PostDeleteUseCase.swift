//
//  PostDeleteUseCase.swift
//  loleye
//
//  Created by 지연 on 12/16/24.
//

import Combine
import Foundation

struct EmptyResponse: Decodable {}

final class PostDeleteUseCase {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func execute() -> AnyPublisher<Void, Error> {
        let target = UserAPI.postDelete
        return networkService.request(target, responseType: EmptyResponse.self)
            .map { _ in }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
