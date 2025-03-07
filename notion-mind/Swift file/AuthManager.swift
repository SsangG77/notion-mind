//
//  AuthManager.swift
//  notion-mind
//
//  Created by 차상진 on 3/7/25.
//

import Foundation
import UIKit


class AuthManager {
    static let shared = AuthManager()

    let loginKey = "isLogin"
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: loginKey)
    }
    
    
    func login() {
        UserDefaults.standard.set(true, forKey: loginKey)
    }
    
    
    func logout() {
        UserDefaults.standard.set(false, forKey: loginKey)
    }
    
    
    
}
