//
//  FetchNodesUseCaseTest.swift
//  notion-mind
//
//  Created by 차상진 on 4/22/25.
//

import Foundation
import RxSwift
import XCTest

class MockNodeRepository: NodeRepository {
    var fetchNodesCalled = false
    var stubbedResponse: Observable<ResponseModel>!

    func fetchNodes() -> Observable<ResponseModel> {
        fetchNodesCalled = true
        return stubbedResponse
    }
}


class FetchNodesUseCaseTest: XCTestCase {
    func test_execute_returnsResponseAndCallsRepository() {
        // given
        let repository = MockNodeRepository()
        let expectedResponse = ResponseModel(deleteIds: ["id1", "id2"], editNodes: [], newNodes: []) // 적절한 테스트용 데이터 작성
        repository.stubbedResponse = Observable.just(expectedResponse)
        
        let useCase = FetchNodesUseCase(nodeRepository: repository)
        var receivedResponse: ResponseModel?
        let expectation = XCTestExpectation(description: "응답 수신")
        
        // when
        _ = useCase.execute()
            .subscribe(onNext: { response in
                receivedResponse = response
                expectation.fulfill()
            })
        
        // then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(repository.fetchNodesCalled)
        XCTAssertEqual(receivedResponse, expectedResponse)
    }

}



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
