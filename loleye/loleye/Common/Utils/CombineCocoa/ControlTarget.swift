//
//  ControlTarget.swift
//  mejai
//
//  Created by 지연 on 10/31/24.
//

import Combine
import UIKit

extension Combine.Publishers {
    struct ControlTarget<Control: AnyObject>: Publisher {
        typealias Output = Void
        typealias Failure = Never
        
        private let control: Control
        private let addTargetAction: (Control, AnyObject, Selector) -> Void
        private let removeTargetAction: (Control?, AnyObject, Selector) -> Void
        
        init(
            control: Control,
            addTargetAction: @escaping (Control, AnyObject, Selector) -> Void,
            removeTargetAction: @escaping (Control?, AnyObject, Selector) -> Void) {
                self.control = control
                self.addTargetAction = addTargetAction
                self.removeTargetAction = removeTargetAction
            }
        
        func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
            let subscription = Subscription(
                subscriber: subscriber,
                control: control,
                addTargetAction: addTargetAction,
                removeTargetAction: removeTargetAction)
            
            subscriber.receive(subscription: subscription)
        }
    }
}

private extension Combine.Publishers.ControlTarget {
    private final class Subscription<S: Subscriber, Control: AnyObject>: Combine.Subscription where S.Input == Void {
        private var subscriber: S?
        weak private var control: Control?
        
        private let removeTargetAction: (Control?, AnyObject, Selector) -> Void
        private let action = #selector(handleAction)
        
        init(
            subscriber: S,
            control: Control,
            addTargetAction: @escaping (Control, AnyObject, Selector) -> Void,
            removeTargetAction: @escaping (Control?, AnyObject, Selector) -> Void) {
                self.subscriber = subscriber
                self.control = control
                self.removeTargetAction = removeTargetAction
                
                addTargetAction(control, self, action)
            }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
            removeTargetAction(control, self, action)
        }
        
        @objc private func handleAction() {
            _ = subscriber?.receive()
        }
    }
}
