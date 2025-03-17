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




class NodeDetailViewController: UIViewController {
    //vm
    let nodeDetailViewModel = NodeDetailViewModel()
    
    
    // component
    lazy var scrollView = setScrollView()
    lazy var contentView = setContentView()
    lazy var propertyView = setPropertyView()
//    lazy var graphView = setGraphView()
//    lazy var graphContentView = setGraphContentView()
    
    //노드 하나당 사이즈
//    let nodePerSize:Int = 150
    // id들 저장
//    var relationNodes:[Node] = []
    
    /// Rect가 지정된 node 저장
//    var savedNode: [Node] = []
    
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
        ]),
        Property(name: "Done", type: .checkbox, value: false)
    ], rect: CGRect())
    
    
    func setNode(node: Node) {
        self.node = node
    }
    
    // viewDidAppear에 추가
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        graphView.contentSize = CGSize(width: 4000, height: 4000)
//        view.layoutIfNeeded() // 🔥 레이아웃 강제 업데이트
//        
//         //스크롤 뷰 상태 확인
//        print("그래프 뷰 프레임: \(graphView.frame)")
//        print("그래프 콘텐츠 뷰 프레임: \(graphContentView.frame)")
//        print("그래프 뷰 contentSize: \(graphView.contentSize)")
//        print("스크롤 가능 여부: \(graphView.isScrollEnabled)")
//        
//        print("graphView.subviews.count: \(graphView.subviews.count)")
//        print("graphContentView.subviews.count: \(graphContentView.subviews.count)")
//
//        graphView.contentSize = CGSize(width: 4000, height: 4000)
//        
//        
//         //viewDidAppear에 추가
//         //5초 후에 자동으로 스크롤이 가능한지 테스트
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            print("스크롤 테스트 시작")
//            let testOffset = CGPoint(x: 1000, y: 1000)
//            self.graphView.setContentOffset(testOffset, animated: true)
//
//            // 스크롤 확인을 위한 지연 후 출력
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                print("스크롤 후 contentOffset: \(self.graphView.contentOffset)")
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let node = node else { return }
        title = node.title
        
        
        
        //scrollview setting
//        graphView.delegate = self
//        graphView.isUserInteractionEnabled = true
           
        


//        /// 부모 scrollView의 터치 전달 방지
//        scrollView.delaysContentTouches = false
//        scrollView.canCancelContentTouches = false
        
        
//        scrollView.delegate = self
        // viewDidLoad에서 기존 코드를 완전히 제거하고 다음으로 대체
        // 내부 스크롤 뷰의 제스처 인식기 우선 순위를 높임
//        graphView.panGestureRecognizer.cancelsTouchesInView = false
//        graphView.panGestureRecognizer.delaysTouchesBegan = false
//        graphView.panGestureRecognizer.delaysTouchesEnded = false

        // 외부 스크롤 뷰의 제스처가 내부를 방해하지 않도록 함
//        scrollView.panGestureRecognizer.cancelsTouchesInView = true
//        scrollView.panGestureRecognizer.require(toFail: graphView.panGestureRecognizer)
        
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
//        graphView.addGestureRecognizer(panGesture)
  
        
        
        setUI()
//        updateUI()
        setupCloseButton()
    }// viewDidLoad
    
    
    
    // 추가할 함수
//    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: graphView)
//
//        // 현재 콘텐츠 오프셋 가져오기
//        var contentOffset = graphView.contentOffset
//
//        // 제스처 이동 방향의 반대 방향으로 콘텐츠 이동
//        contentOffset.x -= translation.x
//        contentOffset.y -= translation.y
//
//        // 새 콘텐츠 오프셋 설정
//        graphView.contentOffset = contentOffset
//
//        // 제스처 이동 거리 초기화
//        gesture.setTranslation(.zero, in: graphView)
//
//        print("수동 팬 제스처: \(contentOffset)")
//    }
    
    
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        // contentSize 재설정 (레이아웃 변경으로 인한 리셋 방지)
//        graphView.contentSize = CGSize(width: 4000, height: 4000)
//
//        print("레이아웃 적용 후 graphView contentSize: \(graphView.contentSize)")
//    }
    
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
