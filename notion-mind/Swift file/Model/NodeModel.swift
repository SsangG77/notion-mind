//
//  NodeModel.swift
//  notion-mind
//
//  Created by 차상진 on 3/8/25.
//

import Foundation
import UIKit

//MARK: - node model
struct Node: Decodable {
    let id: String
    let parentId: String?
    let icon: String?
    let cover: String?
    let title: String?
    let property: [Property]
    var rect: CGRect?
    
    mutating func setRect(rect: CGRect) {
        self.rect = rect
    }
}



//MARK: - 속성 model
struct Property: Codable {
    let name: String
    let type: String /*PropertyType*/
    let value: [ValueType]
}

struct ValueType: Codable {
    let id: String
    let name: String
    let color: String
}

enum PropertyType: Codable {
    case    checkbox, // bool
            email,
            date,
            formula,
            multi_select, // array
            number,
            people,
            phone_number,
            relation, // array
            rich_text,
            select,
            status,
            title,
            url
    //            rollup,
    //            created_by,
    //            created_time,
    //            files,
    //            last_edited_by,
    //            last_edited_time,
}
