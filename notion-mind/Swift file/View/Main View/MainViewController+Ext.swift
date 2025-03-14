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


//MARK: - 컴포넌트
extension MainViewController {
    
    func setScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 10.0
        scrollView.zoomScale = 1.5
        return scrollView
    }
    
    func setContentView() -> UIView {
        let innerView = UIView()
         innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
         
         return innerView
    }
    
    
    func setSettingButton() -> UIButton {
        let settingButton = UIButton()

        settingButton.setImage(UIImage(named: "settingButton"), for: .normal)
        settingButton.imageView?.contentMode = .scaleAspectFit // 이미지 크기 유지
//        settingButton.tintColor = .white
//        settingButton.backgroundColor = .black
        settingButton.clipsToBounds = true
        return settingButton
    }
    
    
}






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
        let frameHeight    = self.view.frame.height  // MainViewController의 높이
        let frameWidth     = self.view.frame.width   // MainViewController의 넓이
        
        //기존 노드들 제거
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        var nodesCount = 0
        
        mainViewModel.isLoading.accept(true)
        
        mainViewModel.nodeCount
            .subscribe(onNext: { count in
                nodesCount = count
            })
            .disposed(by: disposeBag)

        
//        mainViewModel.nodesRelay
        MainViewModel.shared.nodesRelay
            .observe(on: MainScheduler.instance) // UI 업데이트는 메인 스레드에서 실행
            .subscribe(onNext: { [weak self] nodes in
                guard let self = self else { return }
                for node in nodes {
                    let newNode = self.setNode(frame: self.view.frame, node: node, nodesCount: nodesCount)
                    savedNode.append(newNode)
                }
                mainViewModel.isLoading.accept(false)
                
            })
            .disposed(by: disposeBag)

//        mainViewModel.nodesRelay.accept(savedNode) //이거 하면 NodeView가 두번 그려짐
//        drawLine()
        
        //콘텐트 뷰 크기를 업데이트
        contentView.snp.remakeConstraints {
            
            $0.height.equalTo(frameHeight + CGFloat(nodePerSize * nodesCount))
            $0.width.equalTo(frameWidth   + CGFloat(nodePerSize * nodesCount))
            
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            
        }
        
       
        mainViewModel.isLoading.accept(false)
        
    } // updateLayout
    
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
    
    /// newSetNode
    /// - Parameters:
    ///   - frame: 노드 배치를 위한 범위 전체 프레임
    ///   - node: 해당 노드
    ///   - nodesCount: 노드 총 갯수
    /// - Returns: 배치된 노드 Rect 값
    func setNode(frame: CGRect , node: Node, nodesCount: Int) -> Node {
        let frameHeight           = frame.height  // MainViewController의 높이
        let frameWidth            = frame.width   // MainViewController의 넓이
        
        let nodeView = NodeView(node: node)
        
        self.contentView.addSubview(nodeView)
        
        // 임시로 (0,0)에 배치
        nodeView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(0)
            $0.top.equalToSuperview().offset(0)
        }
        
        //배치하고 레이아웃 업데이트
        self.contentView.layoutIfNeeded()
        
        let nodeHeight = nodeView.frame.height
        let nodeWidth = nodeView.frame.width
        
        var randomX: CGFloat
        var randomY: CGFloat
        var newRect: CGRect
        
        let inset: CGFloat = CGFloat((nodePerSize/20) * nodesCount)
        
        repeat {
            
            //(x,y)를 지정할 범위를 정함
            randomX = CGFloat.random(in: inset...(frameWidth + CGFloat(nodePerSize * nodesCount) - nodeWidth - inset))
            randomY = CGFloat.random(in: inset...(frameHeight + CGFloat(nodePerSize * nodesCount) - nodeHeight - inset))
            
            //(x,y, width, height)를 생성해서 모든 node rect배열에 저장
            newRect = CGRect(x: randomX, y: randomY, width: nodeWidth, height: nodeHeight)
        }
        while savedNode.contains(where: { $0.rect.intersects(newRect) })

        
        let newNode = Node(id: node.id, icon: node.icon, cover: node.cover, title: node.title, property: node.property, rect: newRect)
                
       
        nodeView.snp.updateConstraints {
            $0.leading.equalToSuperview().offset(randomX)
            $0.top.equalToSuperview().offset(randomY)
        }
        
        // ✅ 탭 제스처 추가
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nodeViewTapped(_:)))
           nodeView.addGestureRecognizer(tapGesture)
           nodeView.isUserInteractionEnabled = true
        
        return newNode
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
            let nodeRect = node.rect
            let centerX = nodeRect.midX
            let centerY = nodeRect.midY
            
            
            guard !linkedNodeId.contains(node.id) else { continue }
            
            let relationProperties = node.property.filter { $0.type == .relation }
            
            let relatedIds = relationProperties
                .compactMap { $0.value as? [String] }
                .flatMap { $0 }
                .filter { !linkedNodeId.contains($0) }
            
            let relatedNodes = relatedIds.compactMap { id in
                savedNode.first(where: { $0.id == id })
            }
            
            for findNode in relatedNodes {
                let findNodeRect = findNode.rect
                let findNodeCenterX = findNodeRect.midX
                let findNodeCenterY = findNodeRect.midY
                
                drawLine(from: CGPoint(x: centerX, y: centerY), to: CGPoint(x: findNodeCenterX, y: findNodeCenterY))
            }
        }
    } // drawLinks
    
   
   
    
    
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













//====================================================================================================================
#if DEBUG

import SwiftUI


struct MainVCPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewCOntroller: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        MainViewController()
    }
    
}

struct MainVCPresentablePreviews: PreviewProvider {
    static var previews: some View {
        MainVCPresentable()
            .ignoresSafeArea()
    }
}



#endif
