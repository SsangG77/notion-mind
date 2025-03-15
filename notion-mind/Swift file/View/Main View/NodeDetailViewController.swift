//
//  NodeViewController.swift
//  notion-mind
//
//  Created by 차상진 on 3/14/25.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxRelay
//import UIViewSeparator


class NodeDetailViewController: UIViewController {
    
    
    // component
    lazy var scrollView = setScrollView()
    lazy var contentView = setContentView()
    lazy var propertyView = setPropertyView()
    lazy var graphView = setGraphView()
    lazy var graphContentView = setGraphContentView()
    
    //노드 하나당 사이즈
    let nodePerSize:Int = 150
    
    // id들 저장
    var relationNodes:[Node] = []
    
    /// Rect가 지정된 node 저장
    var savedNode: [Node] = []
    
    // rx
    let disposeBag = DisposeBag()
    
    
    
    
//    var node: Node? = nil
    var node: Node? = Node(id: "id 1", icon: "🥬", cover: nil, title: "1 node", property: [
        Property(name: "항목", type: .relation, value: [
            "id 2", "id 3"
        ]),
        Property(name: "pages", type: .relation, value: [
            "id 4", "id 5"
        ]),
        Property(name: "Tech", type: .multi_select, value: [
            "rxswift", "uikit", "mvvm", "sss"
        ])
    ], rect: CGRect())
    
    
    func setNode(node: Node) {
        self.node = node
    }
    
    // viewDidAppear에 추가
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        graphView.contentSize = CGSize(width: 4000, height: 4000)
        view.layoutIfNeeded() // 🔥 레이아웃 강제 업데이트
        
        // 스크롤 뷰 상태 확인
        print("그래프 뷰 프레임: \(graphView.frame)")
        print("그래프 콘텐츠 뷰 프레임: \(graphContentView.frame)")
        print("그래프 뷰 contentSize: \(graphView.contentSize)")
        print("스크롤 가능 여부: \(graphView.isScrollEnabled)")
        
        print("graphView.subviews.count: \(graphView.subviews.count)")
        print("graphContentView.subviews.count: \(graphContentView.subviews.count)")
        
        graphView.contentSize = CGSize(width: 4000, height: 4000)
        
        
        // viewDidAppear에 추가
        // 5초 후에 자동으로 스크롤이 가능한지 테스트
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            print("스크롤 테스트 시작")
            let testOffset = CGPoint(x: 1000, y: 1000)
            self.graphView.setContentOffset(testOffset, animated: true)
            
            // 스크롤 확인을 위한 지연 후 출력
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                print("스크롤 후 contentOffset: \(self.graphView.contentOffset)")
            }
        }
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let node = node else { return }
        title = node.title
        
        
        //scrollview setting
//        graphView.delegate = self
        graphView.isUserInteractionEnabled = true
           
        


//        /// 부모 scrollView의 터치 전달 방지
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = false
        
        
        scrollView.delegate = self
        // viewDidLoad에서 기존 코드를 완전히 제거하고 다음으로 대체
        // 내부 스크롤 뷰의 제스처 인식기 우선 순위를 높임
        graphView.panGestureRecognizer.cancelsTouchesInView = false
        graphView.panGestureRecognizer.delaysTouchesBegan = false
        graphView.panGestureRecognizer.delaysTouchesEnded = false

        // 외부 스크롤 뷰의 제스처가 내부를 방해하지 않도록 함
        scrollView.panGestureRecognizer.cancelsTouchesInView = true
        scrollView.panGestureRecognizer.require(toFail: graphView.panGestureRecognizer)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        graphView.addGestureRecognizer(panGesture)
  
        
        setUI()
        
//        updateUI()
        setupCloseButton()
    }// viewDidLoad
    
    // 추가할 함수
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: graphView)
        
        // 현재 콘텐츠 오프셋 가져오기
        var contentOffset = graphView.contentOffset
        
        // 제스처 이동 방향의 반대 방향으로 콘텐츠 이동
        contentOffset.x -= translation.x
        contentOffset.y -= translation.y
        
        // 새 콘텐츠 오프셋 설정
        graphView.contentOffset = contentOffset
        
        // 제스처 이동 거리 초기화
        gesture.setTranslation(.zero, in: graphView)
        
        print("수동 팬 제스처: \(contentOffset)")
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // contentSize 재설정 (레이아웃 변경으로 인한 리셋 방지)
        graphView.contentSize = CGSize(width: 4000, height: 4000)
        
        print("레이아웃 적용 후 graphView contentSize: \(graphView.contentSize)")
    }
    
}




//MARK: - graph view setting
extension NodeDetailViewController {
    
    func setNodeInGraph(frame: CGRect, node: Node, nodesCount: Int) -> Node {
        let nodeView = NodeView(node: node)
        graphContentView.addSubview(nodeView)

        nodeView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        graphContentView.layoutIfNeeded() // 레이아웃 강제 업데이트

        let nodeHeight = nodeView.frame.height
        let nodeWidth = nodeView.frame.width

        let frameHeight = frame.height
        let frameWidth = frame.width

        var randomX: CGFloat
        var randomY: CGFloat
        var newRect: CGRect

        repeat {
            randomX = CGFloat.random(in: 0...(frameWidth - nodeWidth))
            randomY = CGFloat.random(in: 0...(frameHeight - nodeHeight))
            newRect = CGRect(x: randomX, y: randomY, width: nodeWidth, height: nodeHeight)
        } while savedNode.contains(where: { $0.rect.intersects(newRect) })

        let newNode = Node(id: node.id, icon: node.icon, cover: node.cover, title: node.title, property: node.property, rect: newRect)

        nodeView.snp.updateConstraints {
            $0.leading.equalToSuperview().offset(randomX)
            $0.top.equalToSuperview().offset(randomY)
        }

        return newNode
    }

}



//MARK: - set ui
extension NodeDetailViewController {
    
    func setUI() {
        Service.myPrint("setUI") {
            print(#function)
            print(node)
        }
        self.view.backgroundColor = .white
        
        
        self.view.addSubview(scrollView) //1
        scrollView.addSubview(contentView) //2
        
        
        
        scrollView.snp.makeConstraints { //3
            $0.edges.equalToSuperview()
        }
        
        
        contentView.addSubview(propertyView) //4
        
        
        contentView.snp.makeConstraints {
               $0.width.equalTo(scrollView.frameLayoutGuide.snp.width) // 스크롤뷰의 실제 프레임 너비와 같게 설정
               $0.top.bottom.equalTo(scrollView.contentLayoutGuide) // 상하만 콘텐츠 가이드에 맞춤
               $0.leading.trailing.equalTo(scrollView.frameLayoutGuide) // 좌우는 프레임 가이드에 맞춤
           }
        
        propertyView.snp.makeConstraints { //5
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        
        contentView.addSubview(graphView) //1
        
        graphView.addSubview(graphContentView) //2
        
        graphView.snp.makeConstraints { //3
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(self.propertyView.snp.bottom).inset(-25)
            $0.height.equalTo(350)
        }
        
        let dummyView = UIView()
        dummyView.backgroundColor = .orange
        dummyView.isUserInteractionEnabled = true // 사용자 상호작용 활성화

        // 패턴이나 경계를 추가하여 스크롤이 작동하는지 더 명확하게 확인
        for i in 0..<10 {
            for j in 0..<10 {
                let marker = UIView(frame: CGRect(x: i * 400, y: j * 400, width: 50, height: 50))
                marker.backgroundColor = .red
                dummyView.addSubview(marker)
            }
        }
      
        
        graphContentView.addSubview(dummyView) //4
        
        

        // graphContentView 설정
        graphContentView.snp.makeConstraints {
            $0.edges.equalTo(graphView.contentLayoutGuide)
            $0.width.height.equalTo(4000)
        }

        // dummyView 설정
        dummyView.snp.makeConstraints {
            $0.center.equalToSuperview() // 중앙 정렬
            $0.width.height.equalTo(3000) // graphContentView보다 작게
        }

        
        
    }// setUI
    
    func updateUI() {
        //추가
        guard let node = node else { return }
        print("graphView.frame: \(graphView.frame)")
        print("graphContentView.frame: \(graphContentView.frame)")
        print("graphView.contentSize: \(graphView.contentSize)")
        print("graphView.isScrollEnabled: \(graphView.isScrollEnabled)")

        
//        let frameHeight = self.view.frame.height
//        let frameWidth = self.view.frame.width
        let frameHeight : CGFloat = 2000
        let frameWidth : CGFloat = 2000
        
        
        graphContentView.subviews.forEach { $0.removeFromSuperview() }
        
        
        //변경
        MainViewModel.shared.nodesRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] nodes in
                guard let self = self else { return }
                
                relationNodes = nodes.compactMap { element in
                    let relationProps = element.property.filter { $0.type == .relation }
                    
                    for prop in relationProps {
                        guard let propValue = prop.value as? [String], propValue.contains(node.id) else {
                            continue
                        }
                        return element
                    }
                    return nil
                }
            })
            .disposed(by: disposeBag)
        
        let nodesCount = relationNodes.count
        
        for relationNode in relationNodes {
            let newNode = self.setNodeInGraph(frame: self.view.frame, node: relationNode, nodesCount: nodesCount)
            savedNode.append(newNode)
        }
        graphContentView.snp.remakeConstraints {
            $0.height.equalTo(frameHeight + CGFloat(nodePerSize * nodesCount))
            $0.width.equalTo(frameWidth   + CGFloat(nodePerSize * nodesCount))
            
            $0.edges.equalTo(graphView.contentLayoutGuide)
        }
        
    

        
    } // updateUI
}


//MARK: - set component
extension NodeDetailViewController {
    
    
    func setScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.alwaysBounceVertical = true
            scrollView.alwaysBounceHorizontal = false
        scrollView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
//        scrollView.backgroundColor = .blue
        
        
        
        return scrollView
    }
    
    func setContentView() -> UIView {
        let contentView  = UIView()
        contentView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
        
        return contentView
    }
    
    
    func setPropertyView(/*_ props: [Property<Any>]*/) -> UIStackView {
        let stackView = UIStackView()
//        stackView.backgroundColor = .gray
        stackView.axis = .vertical
        stackView.spacing = 5
      
        
        guard let node = node else {
            print("node property 할당 안됨")
            return stackView
        }
        let props = node.property
        for prop in props {
            
            let hstack = UIStackView()
            hstack.axis = .horizontal
            hstack.distribution = .fill
            hstack.spacing = 10
//            hstack.backgroundColor = .cyan
            
            
            
            let propName = UILabel()
            propName.text = prop.name
            propName.textColor = UIColor.init(hexCode: "787773")
            
            let propValue = UILabel()
            propValue.text = "prop value"
            propValue.numberOfLines = 0
            
            
            hstack.addArrangedSubview(propName)
            hstack.addArrangedSubview(propValue)
            hstack.snp.makeConstraints {
                $0.height.greaterThanOrEqualTo(45)
            }
            propValue.snp.makeConstraints {
                $0.width.equalTo(propName.snp.width).multipliedBy(2.2)
            }
            
            stackView.addArrangedSubview(hstack)
            
            
        }
        
        
        stackView.separator(color: UIColor(hexCode: "787773") , height: 2, spacing: 12)
        
        return stackView
    }
    
    
    func setGraphView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = 1.0
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .never // 추가
        scrollView.delaysContentTouches = false // 추가
        scrollView.canCancelContentTouches = true // 추가
        
        scrollView.isUserInteractionEnabled = true
        scrollView.isDirectionalLockEnabled = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = true
        
        // 스크롤 뷰의 디바운스를 비활성화하여 즉각적인 응답
            scrollView.decelerationRate = .fast
            scrollView.scrollsToTop = false
        
        return scrollView
    }

    
    func setGraphContentView() -> UIView {
        let innerView = UIView()
        innerView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
        innerView.backgroundColor = .brown
        
        
        return innerView
    }
    
    
  
    
    
}







// 닫기 버튼 세팅
extension NodeDetailViewController {
    func setupCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeSettings))
    }
    
    @objc func closeSettings() {
        dismiss(animated: true, completion: nil)
    }
}



//MARK: - zoom setting
extension NodeDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        // 그래프 뷰에서는 그래프 콘텐츠 뷰를 줌 대상으로 지정
        if scrollView == graphView {
            return graphContentView
        }
        return nil
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // 줌 시 콘텐츠 뷰가 중앙에 위치하도록 조정
        if scrollView == graphView {
            let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
            let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
            graphContentView.center = CGPoint(
                x: scrollView.contentSize.width * 0.5 + offsetX,
                y: scrollView.contentSize.height * 0.5 + offsetY
            )
        }
    }
    
    // UIScrollViewDelegate 메서드 추가
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return scrollView != graphView
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // graphView 영역에서 외부 스크롤 뷰의 스크롤을 차단
        if scrollView == self.scrollView {
            let location = scrollView.panGestureRecognizer.location(in: self.view)
            if graphView.frame.contains(location) {
                // 외부 스크롤 뷰의 콘텐츠 오프셋을 이전 위치로 되돌림
                scrollView.panGestureRecognizer.isEnabled = false
                scrollView.panGestureRecognizer.isEnabled = true
            }
        }
    }
}










extension UIView {
    
    func separator(color: UIColor = .black, height: CGFloat = 1, spacing: CGFloat = 0) {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = color
        line.layer.cornerRadius = 3
        self.addSubview(line)
        NSLayoutConstraint.activate([
              line.heightAnchor.constraint(equalToConstant: height),
              line.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              line.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: spacing) // 기본적으로 하단에 배치
          ])
    }
}








//====================================================================================================================
#if DEBUG

import SwiftUI


struct NodeDetailVCPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewCOntroller: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        NodeDetailViewController()
    }
    
}

struct NodeDeatilVCPresentablePreviews: PreviewProvider {
    static var previews: some View {
        NodeDetailVCPresentable()
            .ignoresSafeArea()
    }
}



#endif
