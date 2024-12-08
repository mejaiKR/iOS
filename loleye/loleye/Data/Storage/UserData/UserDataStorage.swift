//
//  UserDataStorage.swift
//  loleye
//
//  Created by 지연 on 12/8/24.
//

import Foundation

final class UserDataStorage {
    static let shared = UserDataStorage()
    
    private init() {}
    
    @UserDefaultsData(key: "isOnboardingCompleted", defaultValue: false)
    var isOnboardingCompleted: Bool
    
    @UserDefaultsData(key: "isLogin", defaultValue: false)
    var isLogin: Bool
}
