//
//  KeychainService.swift
//  mejai
//
//  Created by 지연 on 11/26/24.
//

import Foundation

final class KeychainService: KeychainServiceProtocol {
    
    init() {}
    
    func save(_ value: String, for key: KeychainKey) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainError.stringConversionFailed
        }
        
        try delete(for: key)
        
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func retrieve(for key: KeychainKey) throws -> String {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
        
        guard let data = result as? Data,
              let string = String(data: data, encoding: .utf8) else {
            throw KeychainError.stringConversionFailed
        }
        
        return string
    }
    
    func delete(for key: KeychainKey) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func clear() throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
