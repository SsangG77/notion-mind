
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
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        mainViewModel.fetchNodes()
        
        
        setLayout()
       
        
    } // viewDidLoad
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLayout()
    }

    
    
} // MainViewController






