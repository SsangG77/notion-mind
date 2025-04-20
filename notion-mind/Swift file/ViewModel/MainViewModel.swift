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
    let responseRelay: PublishRelay<ResponseModel> = PublishRelay()
    
    let disposeBag = DisposeBag()
    
    //
    let isLoggedIn = SaveDataManager.getData(type: Bool.self, key: .isLogin) ?? true
    
    // UseCase를 통해 NodeAPI 호출
    let fetchNodesUseCase = FetchNodesUseCase(nodeRepository: NodeAPI())
    
    init() {
        
        savedBotId
            .flatMap { _ in
                self.fetchNodesUseCase.execute()
            }
            .bind(to: self.responseRelay)
            
            .disposed(by: disposeBag)
            
    }
    
    
    /// 로컬에 저장된 nodes를 방출
    /// - Returns: Observable[Node]
    func getSavedNodesObservable() -> Observable<[Node]> {
        
        let nodes = SaveDataManager.loadNodes() ?? []
        
        return Observable.create { observer in
            observer.on(.next(nodes))
            
            return Disposables.create()
        }
        
    }
    
   
    
    
}


