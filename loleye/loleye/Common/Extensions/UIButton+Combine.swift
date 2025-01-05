//
//  UIButton+Combine.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import Combine
import UIKit

extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        controlPublisher(for: .touchUpInside)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
