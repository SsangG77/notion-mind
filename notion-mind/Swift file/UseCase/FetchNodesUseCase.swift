import RxSwift

class FetchNodesUseCase {
    private let nodeRepository: NodeRepository

    init(nodeRepository: NodeRepository) {
        self.nodeRepository = nodeRepository
    }

    func execute() -> Observable<ResponseModel> {
        return nodeRepository.fetchNodes()
    }
} 



