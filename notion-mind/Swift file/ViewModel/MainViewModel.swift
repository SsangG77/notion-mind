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
    let savedBotId: PublishRelay<String> = PublishRelay()
    
//    let deletedIds: PublishRelay<[String]> = PublishRelay()
//    let editNodes: PublishRelay<[Node]> = PublishRelay()
//    let newNodes: PublishRelay<[Node]> = PublishRelay()
    let responseRelay: PublishRelay<ResponseModel> = PublishRelay()
    
    let disposeBag = DisposeBag()
    
    
    // TODO: 데이터를 불러올때 상태 감지 옵저블
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    //
    let isLoggedIn = SaveDataManager.getData(type: Bool.self, key: .isLogin) ?? true
    
    
    
   
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
        
        
            
        
        
//        if SaveDataManager.getData(type: String.self, key: .botId) != nil {
//            nodeApi.fetchNodes()
//                .subscribe(onNext: { responseData in
//                    Service.myPrint("MainViewModel - savedBotId.flatMap true") {
//                        print("file: \(#file) / function: \(#function) / line: \(#line)")
//                        print(responseData)
//                    }
//                    
//                    
//                    
//                })
//                .disposed(by: disposeBag)
//        } else {
//            savedBotId
//                .flatMap { _ in
//                    self.nodeApi.fetchNodes()
//                }
//                .subscribe(onNext: { responseData in
//                    Service.myPrint("MainViewModel - savedBotId.flatMap false") {
//                        print("file: \(#file) / function: \(#function) / line: \(#line)")
//                        print(responseData)
//                    }
//                })
//                .disposed(by: disposeBag)
//        }
        
        savedBotId
            .flatMap { _ in
                self.nodeApi.fetchNodes()
            }
            .bind(to: self.responseRelay)
            .disposed(by: disposeBag)
//            .subscribe(onNext: { responseData in
//                Service.myPrint("MainViewModel - savedBotId.flatMap") {
//                    print("file: \(#file)")
//                    print("function: \(#function)")
//                    print("line: \(#line)")
//                    print(responseData.deleteIds)
//                    print(responseData.editNodes)
//                    print(responseData.newNodes)
//                }
//                
//                self.deletedIds.accept(responseData.deleteIds)
//                self.editNodes.accept(responseData.editNodes)
//                self.newNodes.accept(responseData.newNodes)
//                
//                
//                
//            })
//            .disposed(by: disposeBag)
        
            
//        nodeApi.fetchNodes()
            
        
        
    }
    
    
    
    
   
    
    
}


