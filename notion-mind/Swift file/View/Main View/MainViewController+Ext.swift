//
//  MainViewController+Ext.swift
//  notion-mind
//
//  Created by 차상진 on 3/8/25.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxRelay
import RxCocoa


//MARK: - 레이아웃
extension MainViewController {
    
    func setLayout() {
        scrollView.contentInsetAdjustmentBehavior = .never // 위쪽 safeArea까지 꽉차게 설정
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //프레임 레이아웃 - 메인뷰컨트롤러 사이즈 동일하게 설정
        scrollView.frameLayoutGuide.snp.makeConstraints {
            $0.edges.equalTo(self.view.snp.edges)
        }
        
    }
    
    //레이아웃 업데이트 부분
    func updateLayout() {
        Service.myPrint("updateLayout()") {
            print("file: \(#file)")
            print("function: \(#function)")
            print("line: \(#line)")
        }
        
        let frameHeight    = self.view.frame.height  // MainViewController의 높이
        let frameWidth     = self.view.frame.width   // MainViewController의 넓이
        
        //기존 노드들 제거
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        
        /// 저장되어 있는 [Node]를 화면에 배치하기
        MainViewModel.shared.getSavedNodesObservable()
            .observe(on: MainScheduler.instance) // UI 업데이트는 메인 스레드에서 실행
            .subscribe(onNext: { [weak self] savedNodes in
                guard let self = self else { return }
                let nodesCount = savedNodes.count
                for node in savedNodes {
                    
                    let nodeView = NodeView(node: node)
                    self.contentView.addSubview(nodeView)
                    nodeView.snp.makeConstraints {
                        $0.leading.equalToSuperview().offset(node.rect?.x ?? 0)
                        $0.top.equalToSuperview().offset(node.rect?.y ?? 0)
                    }
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nodeViewTapped(_:)))
                    nodeView.addGestureRecognizer(tapGesture)
                    nodeView.isUserInteractionEnabled = true
                    
                }
                
                self.contentView.snp.remakeConstraints {
                    $0.height.equalTo(frameHeight + CGFloat(self.nodePerSize * nodesCount))
                    $0.width.equalTo(frameWidth   + CGFloat(self.nodePerSize * nodesCount))
                    $0.edges.equalTo(self.scrollView.contentLayoutGuide)
                    
                }
                
            })
            .disposed(by: disposeBag)

        
//      mainViewModel.nodesRelay.accept(savedNode) //이거 하면 NodeView가 두번 그려짐
       

        
    } // updateLayout
    
    
    /// 서버로부터 응답된 삭제 id들과 일치하는 node를 가진 nodeView를 삭제
    /// - Parameter deleteIds: 서버로 응답된 삭제 id 배열
    func removeNodesByDeletedIds(deleteIds: [String]) {
//        Service.myPrint("removeNodesByDeletedIds()") {
//            print("file: \(#file)")
//            print("function: \(#function)")
//            print("line: \(#line)")
//            print("deleted ids: \(deleteIds)")
//        }
        DispatchQueue.main.async {
            for subView in self.contentView.subviews {
                if let nodeView = subView as? NodeView {
                    if deleteIds.contains(nodeView.node.id) {
                        nodeView.removeFromSuperview()
                    }
                }
            }
        }
    } // removeNodesByDeletedIds(deleteIds:)
    
    /// 로컬데이터에서 응답된 편집 노드들과 id가 일치하는건 편집해서 할당하고 아니면 그냥 할당한다.
    /// - Parameters:
    ///   - localNodes: 로컬에 저장되어있는 데이터
    ///   - resEditNodes: 응답된 편집된 데이터
    /// - Returns: 편집된 데이터를 변경되고 기존 데이터를 그대로 있는 노드 배열
    func setEditNodes(localNodes: [Node], resEditNodes: [Node]) -> [Node] {
        // resEditNodes를 Dictionary로 변환해 빠르게 탐색
        let resMap = Dictionary(uniqueKeysWithValues: resEditNodes.map { ($0.id, $0) })
        
        return localNodes.map { local in
            if let res = resMap[local.id] {
                let newNode = Node(
                    id: res.id,
                    parentId: res.parentId,
                    icon: res.icon,
                    cover: res.cover,
                    title: res.title,
                    lastEdit: res.lastEdit,
                    property: res.property,
                    rect: local.rect // 위치 유지
                )
                
                DispatchQueue.main.async {
                    for subView in self.contentView.subviews {
                        if let subView = subView as? NodeView, subView.node.id == local.id {
                            subView.setNewNode(node: newNode)
                        }
                    }
                }
                
                return newNode
            } else {
                return local
            }
        }
    }// setEditNodes(localNodes:, resEditNodes:)
    
    
    
    
    
    
    
    
    
    func positionSettingButtton() {
        let overlayView = TransparentOverlayView() // 버튼을 배치할 오버레이 뷰
        view.addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        overlayView.isUserInteractionEnabled = true // 터치 이벤트 필터링을 위해 true로 설정
        
        
        overlayView.addSubview(settingButton) // overlayView에 버튼 추가

        settingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(60)
            make.width.height.equalTo(50)
        }
        
        settingButton.isUserInteractionEnabled = true
        settingButton.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        
    }
    
}


//MARK: - Action
extension MainViewController {
    
    @objc func settingButtonTapped() {
        
//        let navController = UINavigationController(rootViewController: settingsVC) // 네비게이션 컨트롤러 포함
        settingNavController.modalPresentationStyle = .fullScreen // 전체 화면으로 표시
        present(settingNavController, animated: true, completion: nil)
    }
    
    @objc private func nodeViewTapped(_ sender: UITapGestureRecognizer) {
        
        guard let tappedView = sender.view as? NodeView else { return }
        let tappedNode = tappedView.node

        let detailVC = NodeDetailViewController()
        detailVC.setNode(node: tappedNode)
        
        let navController = UINavigationController(rootViewController: detailVC) // 네비게이션 컨트롤러 포함
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }

}



//MARK: - node, line 설정
extension MainViewController {
    
    func calculateNonOverlappingRect(
        frame: CGRect,
        nodeSize: CGSize,
        existingNodes: [Node]
    ) -> CGRect {
        let frameWidth = frame.width
        let frameHeight = frame.height
        let nodesCount = existingNodes.count
        let inset: CGFloat = CGFloat((nodePerSize / 10) * nodesCount)

        var newRect: CGRect
        repeat {
            let randomX = CGFloat.random(
                in: inset...(frameWidth + CGFloat(nodePerSize * nodesCount) - nodeSize.width - inset)
            )
            let randomY = CGFloat.random(
                in: inset...(frameHeight + CGFloat(nodePerSize * nodesCount) - nodeSize.height - inset)
            )
            newRect = CGRect(x: randomX, y: randomY, width: nodeSize.width, height: nodeSize.height)
        } while existingNodes.contains(where: {
            $0.getCGRect()?.intersects(newRect) ?? false
        })

        return newRect
    }

    
    func createAndAttachNodeView(node: Node, rect: CGRect) {
        let nodeView = NodeView(node: node)
        contentView.addSubview(nodeView)

        // 임시 배치 후 사이즈 측정
        nodeView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(0)
            $0.top.equalToSuperview().offset(0)
        }
        contentView.layoutIfNeeded()

        // 실제 위치로 이동
        nodeView.snp.updateConstraints {
            $0.leading.equalToSuperview().offset(rect.origin.x)
            $0.top.equalToSuperview().offset(rect.origin.y)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nodeViewTapped(_:)))
        nodeView.addGestureRecognizer(tapGesture)
        nodeView.isUserInteractionEnabled = true
    }

    
    
    
    
    /// 직선 그리기
    /// - Parameters:
    ///   - startOffset: 시작점 (x, y)
    ///   - endOffset: 끝점 (x, y)
    func drawLine(from startOffset: CGPoint, to endOffset: CGPoint) {
        let linePath = UIBezierPath()
        linePath.move(to: startOffset)  // 시작점
        linePath.addLine(to: endOffset) // 끝점

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor // 선 색상 (검은색)
        shapeLayer.lineWidth = 5.0  // 선 두께
        shapeLayer.lineCap = .round  // 선 끝 모양
        contentView.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    func drawLinks(savedNode: [Node]) {
        for node in savedNode {
            let nodeRect = node.getCGRect()!
            let centerX = nodeRect.midX
            let centerY = nodeRect.midY
            
            
            guard !linkedNodeId.contains(node.id) else { continue }
            
            //type이 "relation"인 property들만 가져오기
            let relationProperties = node.property.filter { $0.type == "relation" }
            
            // 거기서 value들만 가져오기
            
            
            
            let relatedIds = relationProperties
                .compactMap { $0.value }
                .flatMap { $0 }
                .map { $0.name }
                .filter { !linkedNodeId.contains($0) }
            
            let relatedNodes = relatedIds.compactMap { id in
                savedNode.first(where: { $0.id == id })
            }
            
            for findNode in relatedNodes {
                let findNodeRect = findNode.getCGRect()!
                let findNodeCenterX = findNodeRect.midX
                let findNodeCenterY = findNodeRect.midY
                
                drawLine(from: CGPoint(x: centerX, y: centerY), to: CGPoint(x: findNodeCenterX, y: findNodeCenterY))
            }
        }
    } // drawLinks
    
   
   
    
    
}



//MARK: - 컴포넌트
extension MainViewController {
    
    func setScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
//        scrollView.backgroundColor = .gray
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 10.0
        scrollView.zoomScale = 1.5
        return scrollView
    }
    
    func setContentView() -> UIView {
        let innerView = UIView()
         innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
//        innerView.backgroundColor = .red
         
         return innerView
    }
    
    
    func setSettingButton() -> UIButton {
        let settingButton = UIButton()

        settingButton.setImage(UIImage(named: "settingButton"), for: .normal)
        settingButton.imageView?.contentMode = .scaleAspectFit // 이미지 크기 유지
        settingButton.clipsToBounds = true
        return settingButton
    }
    
    
}


// MARK: - 스크롤뷰 줌 설정
extension MainViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateContentInsets()
    }

    private func updateContentInsets() {
        let scrollViewSize = scrollView.bounds.size
        let contentSize = scrollView.contentSize

        let horizontalInset = max((scrollViewSize.width - contentSize.width) / 2, 0)
        let verticalInset = max((scrollViewSize.height - contentSize.height) / 2, 0)

        scrollView.contentInset = UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        )
    }
}


//
//#Preview {
//    MainViewController()
//}
