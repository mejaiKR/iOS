//
//  UITextField+Combine.swift
//  loleye
//
//  Created by 지연 on 12/5/24.
//

import Combine
import UIKit

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        Publishers.Merge(
            publisher(for: \.text).compactMap { $0 },
            NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
                .compactMap { ($0.object as? UITextField)?.text }
        )
        .removeDuplicates()
        .eraseToAnyPublisher()
    }
    
    var returnPublisher: AnyPublisher<Void, Never> {
        controlPublisher(for: .editingDidEndOnExit)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
