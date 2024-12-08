//
//  KeychainError.swift
//  mejai
//
//  Created by 지연 on 11/26/24.
//

import Foundation

enum KeychainError: Error {
    case stringConversionFailed
    case itemNotFound
    case unexpectedStatus(OSStatus)
}
