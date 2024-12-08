//
//  UserDefaultsData.swift
//  loleye
//
//  Created by 지연 on 12/8/24.
//

import Foundation

@propertyWrapper
struct UserDefaultsData<Value: Codable> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            guard let data = container.object(forKey: key) as? Data else { return defaultValue }
            do {
                let value = try JSONDecoder().decode(Value.self, from: data)
                return value
            } catch {
                print("Failed to decode UserDefaults data for key \(key): \(error)")
                return defaultValue
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                container.set(data, forKey: key)
            } catch {
                print("Failed to encode UserDefaults data for key \(key): \(error)")
            }
        }
    }
}
