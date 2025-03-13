//
//  NodeModel.swift
//  notion-mind
//
//  Created by 차상진 on 3/8/25.
//

import Foundation

//MARK: - node model
struct Node {
    let id: String
    let icon: String?
    let cover: String?
    let title: String?
    let property: [Property<Any>]
    var rect: CGRect
    
    
    
    mutating func setRect(rect: CGRect) {
        self.rect = rect
    }
    
}


//MARK: - 속성 model
struct Property<T> {
    let name: String
    let type: PropertyType
    let value: T
}

enum PropertyType {
    case    checkbox,
            created_by,
            created_time,
            date,
            email,
            files,
            formula,
            last_edited_by,
            last_edited_time,
            multi_select,
            number,
            people,
            phone_number,
            relation,
            rich_text,
            rollup,
            select,
            status,
            title,
            url
}
