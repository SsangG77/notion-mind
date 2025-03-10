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
        scrollView.backgroundColor = .blue
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 10.0
        scrollView.zoomScale = 1.5
        
        
        
        return scrollView
    }
    
    func setContentView() -> UIView {
        let innerView = UIView()
         innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.backgroundColor = .white
         
         return innerView
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
        Service.myPrint("레이아웃 업데이트") {
            print(#function)
            print(#line)
        }
        
        let frameHeight    = self.view.frame.height  // MainViewController의 높이
        let frameWidth     = self.view.frame.width   // MainViewController의 넓이
        
        //기존 노드들 제거
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        var nodesCount = 0
        
        mainViewModel.nodeCount
            .subscribe(onNext: { count in
                Service.myPrint("노드 개수", count) {
                    print(#function)
                    print(#line)
                }
                nodesCount = count
            })
            .disposed(by: disposeBag)

        
        mainViewModel.nodesRelay
            .observe(on: MainScheduler.instance) // UI 업데이트는 메인 스레드에서 실행
            .subscribe(onNext: { [weak self] nodes in
                guard let self = self else { return }

                Service.myPrint("레이아웃 업데이트") {
                    print(#function)
                    print(#line)
                }
                
                savedOffset = nodes.map { node in
                    self.setNode(savedOffset: self.savedOffset, frame: self.view.frame, node: node, nodesCount: nodesCount)
                }
            })
            .disposed(by: disposeBag)

        
        
        //콘텐트 뷰 크기를 업데이트
        contentView.snp.remakeConstraints {
            
            $0.height.equalTo(frameHeight + (150 * CGFloat(nodesCount)) + 500)
            $0.width.equalTo(frameWidth   + (150 * CGFloat(nodesCount)) + 500)
            
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            
        }
        
    }
    
}

extension MainViewController {
    
    func setNode(savedOffset: [CGRect], frame: CGRect , node: Node, nodesCount: Int) -> CGRect {
        
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
        
        let inset: CGFloat = CGFloat(10 * nodesCount)
        
        repeat {
            randomX = CGFloat.random(in: inset...(frameWidth + CGFloat(150 * nodesCount) - nodeWidth - inset))
            randomY = CGFloat.random(in: inset...(frameHeight + CGFloat(150 * nodesCount) - nodeHeight - inset))
            newRect = CGRect(x: randomX, y: randomY, width: nodeWidth, height: nodeHeight)
        } while savedOffset.contains(where: { $0.intersects(newRect)})
        
        
        nodeView.snp.updateConstraints {
            $0.leading.equalToSuperview().offset(randomX)
            $0.top.equalToSuperview().offset(randomY)
        }
        
        
        return newRect
        
        
    }// setNode
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

//
//struct MainVCPresentable: UIViewControllerRepresentable {
//    func updateUIViewController(_ uiViewCOntroller: UIViewControllerType, context: Context) {
//        
//    }
//    
//    func makeUIViewController(context: Context) -> some UIViewController {
//        MainViewController()
//    }
//    
//}
//
//struct MainVCPresentablePreviews: PreviewProvider {
//    static var previews: some View {
//        MainVCPresentable()
//            .ignoresSafeArea()
//    }
//}



#endif
