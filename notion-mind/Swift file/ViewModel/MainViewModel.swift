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
    let nodesRelay: BehaviorRelay<[Node]>
    var nodeCount: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    
    // TODO: 데이터를 불러올때 상태 감지 옵저블
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    
    //
    let disposeBag = DisposeBag()
    
    
   
    init() {
        
        self.nodesRelay = nodeApi.nodesRelay
        
        nodesRelay
            .subscribe(onNext: { nodes in
                self.nodeCount.accept(nodes.count)
                
            })
            .disposed(by: disposeBag)

        fetchNodes()
    }
    
    // **노드 데이터를 불러오는 함수**
        func fetchNodes() {
            isLoading.accept(true) // 로딩 시작
            nodeApi.getNodeByObservable()
            isLoading.accept(false) // 로딩 완료
        }

}


class WebService {
    
    
    // notion auth url
    var auth = ""
    
    
    init() {
        auth = self.setServerIP(.local) + "/auth/notion"
    }
    
    
    
    func setServerIP(_ host: HostType) -> String {
        switch host {
        case .local:
            return "https://1bf9-58-226-117-28.ngrok-free.app" //localhost ngrok
            
        case .global:
            
            return "" // TODO: 서버 호스팅 후 ip 추가
        }
    }
    
    enum HostType {
        case local, global
    }
}
