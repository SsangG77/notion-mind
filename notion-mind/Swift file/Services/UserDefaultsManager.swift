//
//  UserDefaultsManager.swift
//  notion-mind
//
//  Created by 차상진 on 3/18/25.
//

import Foundation



class UserDefaultsManager {
    enum Key: String {
        case isLogin
        case botId
    }
    
   
    static let defaults = UserDefaults.standard
    
    static func setData<T>(value: T, key: Key) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    
    static func getData<T>(type: T.Type, key: Key) -> T?  {
        let value = defaults.object(forKey: key.rawValue) as? T
        return value
    }
    
    static func removeData(key: Key) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
   
    
}
