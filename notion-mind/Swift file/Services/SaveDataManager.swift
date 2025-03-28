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
        case databaseColors
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
    
    // 데이터베이스 색상 관련 메서드
    static func saveDatabaseColor(databaseId: String, color: String) {
        var colors = getDatabaseColors()
        colors[databaseId] = color
        setData(value: colors, key: .databaseColors)
    }
    
    static func getDatabaseColors() -> [String: String] {
        return getData(type: [String: String].self, key: .databaseColors) ?? [:]
    }
    
    static func getDatabaseColor(databaseId: String) -> String? {
        return getDatabaseColors()[databaseId]
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
    
    static func loadNodes() -> [Node]? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("nodes.json")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: url.path) {
            // 파일이 없으면 빈 배열 저장 후 반환
            saveNodes([])
            return []
        }

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
