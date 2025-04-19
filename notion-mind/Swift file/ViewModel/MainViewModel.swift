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


// UseCase로 분리된 로직
class FetchNodesUseCase {
    private let nodeApi: NodeAPI
    private let disposeBag = DisposeBag()
    
    init(nodeApi: NodeAPI) {
        self.nodeApi = nodeApi
    }
    
    func execute(savedBotId: PublishRelay<String>, responseRelay: PublishRelay<ResponseModel>) {
        savedBotId
            .do(onNext: { _ in
                Service.myPrint("2. savedBotId.do(onNext:)") {
                    print("file: \(#file)")
                    print("function: \(#function)")
                    print("line: \(#line)")
                }
            })
            .flatMap { _ in
                self.nodeApi.fetchNodes()
            }
            .bind(to: responseRelay)
            .disposed(by: disposeBag)
    }
}

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
    
    
    // TODO: 데이터를 불러올때 상태 감지 옵저블
//    var isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    //
    let isLoggedIn = SaveDataManager.getData(type: Bool.self, key: .isLogin) ?? true
    
    let fetchNodesUseCase: FetchNodesUseCase
    
    init() {
        // 원래 코드
// savedBotId
//     .do(onNext: { _ in
//         Service.myPrint("2. savedBotId.do(onNext:)") {
//             print("file: \(#file)")
//             print("function: \(#function)")
//             print("line: \(#line)")
//         }
//     })
//     .flatMap { _ in
//         self.nodeApi.fetchNodes()
//     })
//     .bind(to: self.responseRelay)
//     .disposed(by: disposeBag)

// 변경된 코드
fetchNodesUseCase.execute(savedBotId: savedBotId, responseRelay: responseRelay)
        fetchNodesUseCase.execute(savedBotId: savedBotId, responseRelay: responseRelay)
            
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


