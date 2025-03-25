//
//  ResponseModel.swift
//  notion-mind
//
//  Created by 차상진 on 3/25/25.
//

import Foundation

struct ResponseModel: Codable {
    let deleteIds: [String]
    let editNodes: [Node]
    let newNodes: [Node]
}
