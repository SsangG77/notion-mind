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
    
    
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    
    //
    let disposeBag = DisposeBag()
    
    
   
    init() {
        
        nodesRelay
            .subscribe(onNext: {
                self.nodeCount.accept($0.count)
            })
            .disposed(by: disposeBag)
        
    }
    
}



class NodeAPI {
    
    let nodesRelay: BehaviorRelay<[Node]> = BehaviorRelay<[Node]>(value: [])
    
    init() {
        getNodeByObservable()
    }
    
    
    //실제로는 웹소켓 통신 부분
    func getNodeByObservable() {
        Service.myPrint("웹소켓 통신") {
            print(#function)
            print(#line)
        }
        //더미 노드들
        var nodes:[Node] = []
        for i in 0...20 {
            nodes.append(Node(id: "id", icon: "🥬", cover: nil, title: "node \(i) node node", property: []))
        }
        
        nodesRelay.accept(nodes)
        
        
    }
}
