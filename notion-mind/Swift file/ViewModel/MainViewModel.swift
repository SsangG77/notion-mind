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
    
    
    
    //싱글톤 인스턴스
    static let shared = MainViewModel()
    
    
    
    // Rx
    var nodesRelay: BehaviorRelay<[Node]> = BehaviorRelay(value: [])
    var nodeCount: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    
    // TODO: 데이터를 불러올때 상태 감지 옵저블
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    
    //
    let disposeBag = DisposeBag()
    
    
   
    init() {
        
//        nodeApi.fetchNodes()
//            .withUnretained(self)
//            .subscribe(onNext: { vm, nodes in
//                vm.nodesRelay.accept(nodes)
//                vm.nodeCount.accept(nodes.count)
//                Service.myPrint("MainViewModel.nodeApi.fetchNodes") {
//                    print("node count : ", nodes.count)
//                }
//            })
//            .disposed(by: disposeBag)
        
        nodeApi.fetchNodes()
    }
    
    // 더미 데이터를 불러오는 함수
//        func fetchNodes() {
//            isLoading.accept(true) // 로딩 시작
//            nodeApi.getNodeByObservable()
//            isLoading.accept(false) // 로딩 완료
//        }
    
    
    
   
    
    
}


