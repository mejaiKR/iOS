//
//  Reusable.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import Foundation

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
