//
//  UserDefaultsManager.swift
//  notion-mind
//
//  Created by 차상진 on 3/18/25.
//

import Foundation



class SaveDataManager {
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
    
    
    static func saveNodes(_ nodes: [Node]) {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("nodes.json")
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let data = try encoder.encode(nodes)
            try data.write(to: url)
        } catch {
            print("저장 실패:", error)
        }
    }
    
    func loadNodes() -> [Node]? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("nodes.json")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode([Node].self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print("데이터 손상:", context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("키 없음: \(key), context: \(context)")
        } catch let DecodingError.typeMismatch(type, context) {
            print("타입 불일치: \(type), context: \(context)")
        } catch let DecodingError.valueNotFound(value, context) {
            print("값 없음: \(value), context: \(context)")
        } catch {
            print("불러오기 실패:", error)
        }
        return nil
    }



    
    
}
