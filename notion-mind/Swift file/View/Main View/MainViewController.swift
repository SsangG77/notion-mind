
//  MainViewController.swift
//  notion-mind
//
//  Created by 차상진 on 3/7/25.
//

import Foundation
import UIKit
import RxSwift
import RxRelay


class MainViewController: UIViewController {
    
    //컴포넌트
    lazy var scrollView:    UIScrollView = setScrollView()
    lazy var contentView :  UIView       = setContentView()
    
    //뷰모델
    let mainViewModel = MainViewModel()
    
    
    //Rx 설정
    let disposeBag = DisposeBag()
 
    
    /// 배치된 노드 rect 저장 배열
    var savedOffset: [CGRect] = []
    
    /// Rect가 지정된 node 저장
    var savedNode: [Node] = []
    
    /// 연결 처리된 node 저장
    var linkedNodeId: [String] = []
    
    
    
    /// node 하나당 지정할 높이, 넓이
    let nodePerSize:Int = 100
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        
       

        
        setLayout()
        
        mainViewModel.nodesRelay
            .bind(to: { _ in
                self.mainViewModel.isLoading.accept(true)
            })
        
        
//        mainViewModel.isLoading
//            .subscribe(onNext: { isLoading in
//            })
//            .disposed(by: disposeBag)
        
        
       

       
        
    } // viewDidLoad
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateLayout()
        
        
//        self.drawLine(from: CGPoint(x: 50, y: 50), to: CGPoint(x: 600, y: 400))
        
        drawLinks(savedNode: savedNode)
        
    }

    
    
} // MainViewController






