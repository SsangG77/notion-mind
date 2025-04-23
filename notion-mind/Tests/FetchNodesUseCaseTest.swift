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

