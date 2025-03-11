//
//  MainViewModel.swift
//  notion-mind
//
//  Created by 차상진 on 3/9/25.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa


//실제 로직 처리
class MainViewModel {
    
    //의존성
    let nodeApi = NodeAPI()
    
    
    // Rx
    lazy var nodesRelay = nodeApi.nodesRelay
    
    
    
    var nodeCount: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    
    // TODO: 데이터를 불러올때 상태 감지 옵저블
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    
    //
    let disposeBag = DisposeBag()
    
    
   
    init() {
        

        nodesRelay
            .subscribe(onNext: { nodes in
                self.nodeCount.accept(nodes.count)
                
            })
            .disposed(by: disposeBag)

        
        nodeApi.getNodeByObservable()
    }


    
}



class NodeAPI {
    let nodesRelay: BehaviorRelay<[Node]> = BehaviorRelay(value: [])

    
    func getNodeByObservable() {

        var nodes: [Node] = []
        nodes.append(Node(id: "id 1", icon: "🥬", cover: nil, title: "1 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                "id 2", "id 3"
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 2", icon: "🥬", cover: nil, title: "2 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                "id 1"
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 3", icon: "🥬", cover: nil, title: "3 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                "id 1"
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 4", icon: "🥬", cover: nil, title: "4 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                "id 5", "id 6", "id 7"
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 5", icon: "🥬", cover: nil, title: "5 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                "id 4"
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 6", icon: "🥬", cover: nil, title: "6 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                "id 4"
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 7", icon: "🥬", cover: nil, title: "7 node", property: [
            Property(name: "하위항목", type: .relation, value: [
                "id 4"
            ])
        ], rect: CGRect()))
//        nodes.append(Node(id: "id 1", icon: "🥬", cover: nil, title: "1 node", property: [
//            Property(name: "하위항목", type: .relation, value: [
//                "id 2", "id 3"
//            ])
//        ], rect: CGRect()))
//        nodes.append(Node(id: "id 1", icon: "🥬", cover: nil, title: "1 node", property: [
//            Property(name: "하위항목", type: .relation, value: [
//                "id 2", "id 3"
//            ])
//        ], rect: CGRect()))
//        nodes.append(Node(id: "id 1", icon: "🥬", cover: nil, title: "1 node", property: [
//            Property(name: "하위항목", type: .relation, value: [
//                "id 2", "id 3"
//            ])
//        ], rect: CGRect()))
//        nodes.append(Node(id: "id 1", icon: "🥬", cover: nil, title: "1 node", property: [
//            Property(name: "하위항목", type: .relation, value: [
//                "id 2", "id 3"
//            ])
//        ], rect: CGRect()))
        

        nodesRelay.accept(nodes)
    }
}

