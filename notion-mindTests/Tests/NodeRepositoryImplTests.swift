//
//  NodeRepositoryImplTests.swift
//  notion-mind
//
//  Created by 차상진 on 4/23/25.
//

import Foundation
import XCTest
import RxSwift



class MockLocalDataSource: LocalNodeDataSource {
    var called = false
    
    func fetchNodeSummaries() -> [RequestNodeModel] {
        called = true
        return [
            RequestNodeModel(id: "id 1", lastEdit: Date())
        ]
    }
}

class MockRemoteNodeDataSource: RemoteNodeDataSource {
    var called = false
    var receivedRequest: RequestModel?
    
    func fetchNodes(request: RequestModel) -> Observable<ResponseModel> {
        called = true
        receivedRequest = request
        return Observable.just(
            ResponseModel(deleteIds: ["id1", "id2"], editNodes: [], newNodes: [])
        )
    }
}



class NodeRepositoryImplTests: XCTestCase {
    func test_fetchnodes() {
        let localDataSourceImplTest = MockLocalDataSource()
        let remoteDataSourceImplTest = MockRemoteNodeDataSource()
        let nodeRepositoryImpl = NodeRepositoryImpl(local: localDataSourceImplTest, remote: remoteDataSourceImplTest)
        
        let expectation = XCTestExpectation(description: "fetchNodes emits")
        
        var result: ResponseModel?
        
        _ = nodeRepositoryImpl.fetchNodes()
            .subscribe(onNext: { res in
                result = res
                expectation.fulfill()
            })
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(localDataSourceImplTest.called)
        XCTAssertTrue(remoteDataSourceImplTest.called)
        XCTAssertEqual(remoteDataSourceImplTest.receivedRequest?.nodes.first?.id, "id1")
        XCTAssertEqual(result?.deleteIds, ["id1"])
        
    }
}
