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



//class NodeAPI {
//    
//    static let shared = NodeAPI()
//    
//    //service
//    let webService = WebService()
//    
//    //rx
//    let nodesRelay: BehaviorRelay<[Node]> = BehaviorRelay(value: [])
//
//    
//    func fetchNodes() -> Observable<ResponseModel> {
//       
//        
//        let requestModel = RequestModel(nodes: requestData())
//        
//        let url = URL(string: webService.nodeData)!
//        
//        return Observable.create { observer in
//            do {
//                let encoder = JSONEncoder()
//                encoder.dateEncodingStrategy = .iso8601
//
//                let jsonData = try encoder.encode(requestModel)
//                
//                
//                var request = URLRequest(url: url)
//                request.httpMethod = "POST"
//                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//                request.httpBody = jsonData
//                
//                // URLSession 생성 (기본 세션)
//                let session: URLSession = URLSession(configuration: .default)
//                
//                
//                let task = session.dataTask(with: request) { (data, response, error) in
//                    
//                    if let error = error {
//                        Service.myPrint("fetchNodes() - error") {
//                            print(error)
//                        }
//                        observer.onError(error)
//                    }
//                    guard let data = data else { return }
//                    
//                    do {
//                        let decoder = JSONDecoder()
//                        decoder.dateDecodingStrategy = .iso8601
//                        let responseData = try decoder.decode(ResponseModel.self, from: data)
//                       
//                        
//                        observer.onNext(responseData)
//                    } catch {
//                        Service.myPrint("fetchNodes() - error") {
//                            print(error)
//                        }
//                        observer.onError(error)
//                    }
//                }
//                
//                task.resume()
//                
//                return Disposables.create {
//                    task.cancel()
//                }
//            } catch {
//                observer.onError(error)
//                return Disposables.create()
//            }
//            
//            
//        }// Observser create
//    }
//    
//    /// 저장되어있는 nodes에서 id, lastEdit 데이터만 가져와서 반환하는 함수
//    /// - Returns: [RequestNodeModel]
//    func requestData() -> [RequestNodeModel] {
//        return SaveDataManager.loadNodes()?.map { node in
//            RequestNodeModel(id: node.id, lastEdit: node.lastEdit)
//        } ?? []
//    }
//}

//MARK: - 클린 아키텍처 적용

protocol LocalNodeDataSource {
    func fetchNodeSummaries() -> [RequestNodeModel]
}

class LocalNodeDataSourceImpl: LocalNodeDataSource {
    func fetchNodeSummaries() -> [RequestNodeModel] {
        // SaveDataManager에서 노드 불러와서 id + lastEdit만 추출
        return SaveDataManager.loadNodes()?.map { node in
            RequestNodeModel(id: node.id, lastEdit: node.lastEdit)
        } ?? []
    }
}



protocol RemoteNodeDataSource {
    func fetchNodes(request: RequestModel) -> Observable<ResponseModel>
}

class RemoteNodeDataSourceImpl: RemoteNodeDataSource {
    
    //service
    let webService = WebService()
    
    func fetchNodes(request: RequestModel) -> Observable<ResponseModel> {
        
        let url = URL(string: webService.nodeData)!
        
        return Observable.create { observer in
            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .iso8601

                let jsonData = try encoder.encode(request)
                
                
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
}




protocol NodeRepository {
    func fetchNodes() -> Observable<ResponseModel>
}

class NodeRepositoryImpl: NodeRepository {
    private let local: LocalNodeDataSource
    private let remote: RemoteNodeDataSource
    
    
    init(local: LocalNodeDataSource, remote: RemoteNodeDataSource) {
        self.local = local
        self.remote = remote
    }
    
    func fetchNodes() -> Observable<ResponseModel> {
        let requestNodeModel = local.fetchNodeSummaries()
        return remote.fetchNodes(request: RequestModel(nodes: requestNodeModel))
    }
}

