//
//  UIControl+Combine.swift
//  mejai
//
//  Created by 지연 on 10/27/24.
//

import Combine
import UIKit

extension UIControl {
    func controlPublisher(for events: UIControl.Event) -> AnyPublisher<UIControl, Never> {
        ControlEvent(control: self, events: events)
            .eraseToAnyPublisher()
    }
}
