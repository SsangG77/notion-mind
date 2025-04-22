//
//  NodeModel.swift
//  notion-mind
//
//  Created by 차상진 on 3/8/25.
//

import Foundation
import UIKit

//MARK: - node model
struct Node: Codable, Equatable {
    let id: String
    let parentId: String?
    let icon: String?
    let cover: String?
    let title: String?
    let lastEdit: Date
    let property: [Property]
    
    var rect: CodableRect?
    
    func getCGRect() -> CGRect? {
        rect?.cgRect
    }
}


//MARK: - 속성 model
struct Property: Codable, Equatable {
    let name: String
    let type: String
    let value: [ValueType]
}

struct ValueType: Codable, Equatable {
    let id: String
    let name: String
    let color: String
}



struct CodableRect: Codable, Equatable {
    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
    let height: CGFloat

    init(from rect: CGRect) {
        self.x = rect.origin.x
        self.y = rect.origin.y
        self.width = rect.size.width
        self.height = rect.size.height
    }

    var cgRect: CGRect {
        CGRect(x: x, y: y, width: width, height: height)
    }
}
