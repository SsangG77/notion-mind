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

protocol NodeRepository {
    func fetchNodes() -> Observable<ResponseModel>
}

class NodeAPI: NodeRepository {
    
    static let shared = NodeAPI()
    
    //service
    let webService = WebService()
    
    
    //rx
    let nodesRelay: BehaviorRelay<[Node]> = BehaviorRelay(value: [])

    
    func fetchNodes() -> Observable<ResponseModel> {
        Service.myPrint("3. fetchNodes()") {
            print("file: \(#file)")
            print("function: \(#function)")
            print("line: \(#line)")
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
                        Service.myPrint("response Data") {
                            print("file: \(#file)")
                            print("function: \(#function)")
                            print("line: \(#line)")
                            print(responseData)
                        }
                        
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

