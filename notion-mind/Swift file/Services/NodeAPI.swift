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
    
    // viewModel
//    let mainViewModel: MainViewModel = MainViewModel()
    
    
    //rx
    let nodesRelay: BehaviorRelay<[Node]> = BehaviorRelay(value: [])

    
    
    //실제로는 웹소켓에서 데이터가 변경될때만 데이터를 수신함.
    //현재는 더미 데이터
//    func getNodeByObservable() {
//        var nodes: [Node] = []
//        nodes.append(Node(id: "id 1", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: "https://images.unsplash.com/photo-1742387436246-a7288481be39?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "1 node", lastEdit: Date(), property: [
//            Property(name: "하위항목", type: "relation", value: [
//                ValueType(id: UUID().uuidString, name: "id 2", color: "clear"),
//                ValueType(id: UUID().uuidString, name: "id 3", color: "clear"),
//            ]),
//            Property(name: "Tech", type: "multi_select", value: [
//                
//                ValueType(id: UUID().uuidString, name: "rxswift", color: "red"),
//                ValueType(id: UUID().uuidString, name: "uikit", color: "green"),
//                ValueType(id: UUID().uuidString, name: "mvvm", color: "blue"),
//            ]),
//            Property(name: "Done", type: "checkbox", value: [
//                ValueType(id: UUID().uuidString, name: "false", color: "clear"),
//            ])
//        ], rect: CodableRect(from: CGRect())))
//        nodes.append(Node(id: "id 2", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "2 node", lastEdit: Date(), property: [
//            Property(name: "하위항목", type: "relation", value: [
//                ValueType(id: UUID().uuidString, name: "id 1", color: "clear"),
//            ]),
//            Property(name: "Tech", type: "multi_select", value: [
//                
//                ValueType(id: UUID().uuidString, name: "rxswift", color: "red"),
//                ValueType(id: UUID().uuidString, name: "uikit", color: "green"),
//                ValueType(id: UUID().uuidString, name: "mvvm", color: "blue"),
//            ]),
//            Property(name: "Done", type: "checkbox", value: [
//                ValueType(id: UUID().uuidString, name: "false", color: "clear"),
//            ])
//        ], rect: CodableRect(from: CGRect())))
//        nodes.append(Node(id: "id 3", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: "https://images.unsplash.com/photo-1741990417513-81d6d95b5bbb?q=80&w=2191&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "3 node", lastEdit: Date(), property: [
//            Property(name: "하위항목", type: "relation", value: [
//                ValueType(id: UUID().uuidString, name: "id 1", color: "clear"),
//            ]),
//            Property(name: "Tech", type: "multi_select", value: [
//                
//                ValueType(id: UUID().uuidString, name: "rxswift", color: "red"),
//                ValueType(id: UUID().uuidString, name: "uikit", color: "green"),
//                ValueType(id: UUID().uuidString, name: "mvvm", color: "blue"),
//            ]),
//            Property(name: "Done", type: "checkbox", value: [
//                ValueType(id: UUID().uuidString, name: "false", color: "clear"),
//            ])
//        ], rect: CodableRect(from: CGRect())))
//        nodes.append(Node(id: "id 4", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "4 node", lastEdit: nil, property: [
//            Property(name: "하위항목", type: "relation", value: [
//                ValueType(id: UUID().uuidString, name: "id 5", color: "clear"),
//                ValueType(id: UUID().uuidString, name: "id 6", color: "clear"),
//                ValueType(id: UUID().uuidString, name: "id 7", color: "clear"),
//            ])
//        ], rect: CodableRect(from: CGRect())))
//        nodes.append(Node(id: "id 5", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "5 node", lastEdit: Date(), property: [
//            Property(name: "하위항목", type: "relation", value: [
//                ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
//            ])
//        ], rect: CodableRect(from: CGRect())))
//        nodes.append(Node(id: "id 6", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "6 node", lastEdit: Date(), property: [
//            Property(name: "하위항목", type: "relation", value: [
//                ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
//            ])
//        ], rect: CodableRect(from: CGRect())))
//        nodes.append(Node(id: "id 7", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "7 node", lastEdit: Date(), property: [
//            Property(name: "하위항목", type: "relation", value: [
//                ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
//            ])
//        ], rect: CodableRect(from: CGRect())))
//        nodes.append(Node(id: "id 8", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: "https://images.unsplash.com/photo-1737587653765-94bc8fe7b541?q=80&w=2662&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "8 node", lastEdit: Date(), property: [
//            Property(name: "하위항목", type: "relation", value: [
//                ValueType(id: UUID().uuidString, name: "id 3", color: "clear"),
//            ])
//        ], rect: CodableRect(from: CGRect())))
//        nodes.append(Node(id: "id 9", parentId: "1a4ee035-a51f-808c-82e5-f6abb4adfac9", icon: "🥬", cover: nil, title: "9 node", lastEdit: Date(), property: [
//            Property(name: "하위항목", type: "relation", value: [
//                ValueType(id: UUID().uuidString, name: "id 3", color: "clear"),
//            ])
//        ], rect: CodableRect(from: CGRect())))
//        nodesRelay.accept(nodes)
//    } //getNodeByObservable()
    
    
//    func fetchNodes() -> Observable<[Node]> {
//        print(#function, #line, "fetchNodes")
//        let url = URL(string: webService.nodeData)!
//        return Observable.create { observer in
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            // URLSession 생성 (기본 세션)
//            let session: URLSession = URLSession(configuration: .default)
//            
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//            
//            let task = session.dataTask(with: request) { (data, response, error) in
//                if let error = error {
//                    observer.onError(error)
//                    return
//                }
//                guard let data = data else {
//                    observer.onError(NSError(domain: "No Data", code: -1))
//                    return
//                }
//                
//                do {
//                    let users = try decoder.decode([Node].self, from: data)
//                    observer.onNext(users)
//                    observer.onCompleted()
//                } catch {
//                    Service.myPrint("fetchNodes() - error") {
//                        print(error)
//                    }
//                    observer.onError(error)
//                }
//            }
//            task.resume()
//            
//            return Disposables.create {
//                task.cancel()
//            }
//            
//        } // Observable.create
//    }
    
    
    
    
    func fetchNodes() -> Observable<ResponseModel> {
        Service.myPrint(#function) {
            print("fetchNodes 실행됨")
        }
        
        let requestModel = RequestModel(nodes: requestData())
        
        let url = URL(string: webService.nodeData)!
        
        return Observable.create { observer in
            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .iso8601

                let jsonData = try encoder.encode(requestModel)
                
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                // URLSession 생성 (기본 세션)
                let session: URLSession = URLSession(configuration: .default)
                
                
                let task = session.dataTask(with: request) { (data, response, error) in
                    
                    if let error = error {
                        Service.myPrint("fetchNodes() - error") {
                            print(error)
                        }
                        observer.onError(error)
                    }
                    guard let data = data else { return }
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let responseData = try decoder.decode(ResponseModel.self, from: data)
//                        Service.myPrint("NodeAPI - fetchNodes()") {
//                            print(responseData)
//                        }
                        observer.onNext(responseData)
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
            } catch {
                observer.onError(error)
                return Disposables.create()
            }
            
            
        }// Observser create
    }
    
    /// 저장되어있는 nodes에서 id, lastEdit 데이터만 가져와서 반환하는 함수
    /// - Returns: [RequestNodeModel]
    func requestData() -> [RequestNodeModel] {
        return SaveDataManager.loadNodes()?.map { node in
            RequestNodeModel(id: node.id, lastEdit: node.lastEdit)
        } ?? []
    }
}

