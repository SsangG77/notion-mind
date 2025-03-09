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
    
    let disposeBag = DisposeBag()
    
    let nodeCount: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    let nodesRelay: BehaviorRelay<[Node]> = BehaviorRelay<[Node]>(value: [])
   
    
    func fetchNodes() {
        
        NodeAPI.getNodeByObservable()
            .withUnretained(self)
            .subscribe(onNext: { vm, nodes in
                vm.nodesRelay.accept(nodes)
            })
            .disposed(by: disposeBag)
        
        nodeCount.accept(nodesRelay.value.count)
    }
    
}



class NodeAPI {
    
    
    static func getNodeByObservable() -> Observable<[Node]> {
        //더미 노드들
        var nodes:[Node] = []
        for i in 0...20 {
            nodes.append(Node(id: "id", icon: "🥬", cover: nil, title: "node \(i) node node", property: []))
        }
        

        
        return Observable<[Node]>.create { observer in
            observer.onNext(nodes)
            observer.onCompleted()
            
            
            return Disposables.create()
        }
    }
}
