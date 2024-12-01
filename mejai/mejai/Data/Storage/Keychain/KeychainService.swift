//
//  KeychainService.swift
//  mejai
//
//  Created by 지연 on 11/26/24.
//

import Foundation

final class KeychainService: KeychainServiceProtocol {
    private let service = "LOLEYE"
    
    init() {}
    
    private func makeQuery(for key: KeychainKey) -> [String: Any] {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue
        ]
    }
    
    func save(_ value: String, for key: KeychainKey) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainError.stringConversionFailed
        }
        
        var query = makeQuery(for: key)
        query[kSecValueData as String] = data
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            // 이미 존재하는 경우 업데이트
            try update(value, for: key)
        } else if status != errSecSuccess {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func retrieve(for key: KeychainKey) throws -> String {
        var query = makeQuery(for: key)
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        
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
        let query = makeQuery(for: key)
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    private func update(_ value: String, for key: KeychainKey) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainError.stringConversionFailed
        }
        
        let query = makeQuery(for: key)
        let attributes: [String: Any] = [kSecValueData as String: data]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
