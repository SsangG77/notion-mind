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
    
    static let shared = NodeAPI()
    
    //service
    let webService = WebService()
    
    
    
    //
    let nodesRelay: BehaviorRelay<[Node]> = BehaviorRelay(value: [])

    
    
    //실제로는 웹소켓에서 데이터가 변경될때만 데이터를 수신함.
    //현재는 더미 데이터
    func getNodeByObservable() {
        var nodes: [Node] = []
        nodes.append(Node(id: "id 1", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: "https://images.unsplash.com/photo-1742387436246-a7288481be39?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "1 node", property: [
            Property(name: "하위항목", type: "relation", value: [
                ValueType(id: UUID().uuidString, name: "id 2", color: "clear"),
                ValueType(id: UUID().uuidString, name: "id 3", color: "clear"),
            ]),
            Property(name: "Tech", type: "multi_select", value: [
                
                ValueType(id: UUID().uuidString, name: "rxswift", color: "red"),
                ValueType(id: UUID().uuidString, name: "uikit", color: "green"),
                ValueType(id: UUID().uuidString, name: "mvvm", color: "blue"),
            ]),
            Property(name: "Done", type: "checkbox", value: [
                ValueType(id: UUID().uuidString, name: "false", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 2", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "2 node", property: [
            Property(name: "하위항목", type: "relation", value: [
                ValueType(id: UUID().uuidString, name: "id 1", color: "clear"),
            ]),
            Property(name: "Tech", type: "multi_select", value: [
                
                ValueType(id: UUID().uuidString, name: "rxswift", color: "red"),
                ValueType(id: UUID().uuidString, name: "uikit", color: "green"),
                ValueType(id: UUID().uuidString, name: "mvvm", color: "blue"),
            ]),
            Property(name: "Done", type: "checkbox", value: [
                ValueType(id: UUID().uuidString, name: "false", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 3", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: "https://images.unsplash.com/photo-1741990417513-81d6d95b5bbb?q=80&w=2191&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "3 node", property: [
            Property(name: "하위항목", type: "relation", value: [
                ValueType(id: UUID().uuidString, name: "id 1", color: "clear"),
            ]),
            Property(name: "Tech", type: "multi_select", value: [
                
                ValueType(id: UUID().uuidString, name: "rxswift", color: "red"),
                ValueType(id: UUID().uuidString, name: "uikit", color: "green"),
                ValueType(id: UUID().uuidString, name: "mvvm", color: "blue"),
            ]),
            Property(name: "Done", type: "checkbox", value: [
                ValueType(id: UUID().uuidString, name: "false", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 4", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "4 node", property: [
            Property(name: "하위항목", type: "relation", value: [
                ValueType(id: UUID().uuidString, name: "id 5", color: "clear"),
                ValueType(id: UUID().uuidString, name: "id 6", color: "clear"),
                ValueType(id: UUID().uuidString, name: "id 7", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 5", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "5 node", property: [
            Property(name: "하위항목", type: "relation", value: [
                ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 6", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "6 node", property: [
            Property(name: "하위항목", type: "relation", value: [
                ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 7", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "7 node", property: [
            Property(name: "하위항목", type: "relation", value: [
                ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 8", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: "https://images.unsplash.com/photo-1737587653765-94bc8fe7b541?q=80&w=2662&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "8 node", property: [
            Property(name: "하위항목", type: "relation", value: [
                ValueType(id: UUID().uuidString, name: "id 3", color: "clear"),
            ])
        ], rect: CGRect()))
        nodes.append(Node(id: "id 9", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "9 node", property: [
            Property(name: "하위항목", type: "relation", value: [
                ValueType(id: UUID().uuidString, name: "id 3", color: "clear"),
            ])
        ], rect: CGRect()))
        nodesRelay.accept(nodes)
    } //getNodeByObservable()
    
    
    func fetchNodes() -> Observable<[Node]> {
        print(#function, #line, "fetchNodes")
        let url = URL(string: webService.nodeData)!
        return Observable.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // URLSession 생성 (기본 세션)
            let session: URLSession = URLSession(configuration: .default)
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
                guard let data = data else {
                    observer.onError(NSError(domain: "No Data", code: -1))
                    return
                }
                

                
                do {
                    let users = try JSONDecoder().decode([Node].self, from: data)
//                    Service.myPrint("response node data") {
//                        print(users)
//                    }
                    observer.onNext(users)
                    observer.onCompleted()
                } catch {
                    Service.myPrint("fetchNodes() - error") {
                        print(error)
                    }
                    observer.onError(error)
                }
                
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
            
        } // Observable.create
    }
}

