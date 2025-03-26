//
//  RequestModel.swift
//  notion-mind
//
//  Created by 차상진 on 3/25/25.
//

import Foundation

struct RequestModel: Codable {
    let botId: String
    let nodes: [RequestNodeModel]
    
    init(nodes: [RequestNodeModel]) {
        
        self.botId = SaveDataManager.getData(type: String.self, key: .botId) ?? "bot id 없음"
        self.nodes = nodes
    }
}


