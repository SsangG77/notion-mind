//
//  NodeAPI.swift
//  notion-mind
//
//  Created by 차상진 on 3/16/25.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa


class NodeAPI {
    let nodesRelay: BehaviorRelay<[Node]> = BehaviorRelay(value: [])

    
    
    //실제로는 웹소켓에서 데이터가 변경될때만 데이터를 수신함.
    //현재는 더미 데이터
    func getNodeByObservable() {

        var nodes: [Node] = []
        nodes.append(Node(id: "id 1", parrentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "1 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                ValueType(id: UUID().uuidString, name: "id 2", color: "clear"),
                ValueType(id: UUID().uuidString, name: "id 3", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 2", parrentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "2 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                ValueType(id: UUID().uuidString, name: "id 1", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 3", parrentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "3 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                ValueType(id: UUID().uuidString, name: "id 1", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 4", parrentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "4 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                ValueType(id: UUID().uuidString, name: "id 5", color: "clear"),
                ValueType(id: UUID().uuidString, name: "id 6", color: "clear"),
                ValueType(id: UUID().uuidString, name: "id 7", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 5", parrentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "5 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 6", parrentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "6 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 7", parrentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "7 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 8", parrentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "8 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                ValueType(id: UUID().uuidString, name: "id 3", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 9", parrentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "9 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                ValueType(id: UUID().uuidString, name: "id 3", color: "clear"),
            ])
        ], rect: CGRect()))
        

        nodesRelay.accept(nodes)
    }
}

