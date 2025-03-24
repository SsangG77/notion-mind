
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
    lazy var settingButton: UIButton    =  setSettingButton()
    
    
    //뷰모델
    let mainViewModel: MainViewModel
//    private let loginViewModel: LoginViewModel
    
    
    //viewcontroller
    lazy var settingsVC = SettingViewController()
    lazy var settingNavController = UINavigationController(rootViewController: settingsVC)
    
    
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
    
    
    init(viewModel: MainViewModel) {
        self.mainViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self

        setLayout()
        positionSettingButtton()
        
//        mainViewModel.nodesRelay
//            .bind(to: { _ in
//                self.mainViewModel.isLoading.accept(true)
//            })
        
        if let savedId = SaveDataManager.getData(type: String.self, key: .botId) {
            Service.myPrint("MainViewController - savedId") {
                print("file: \(#file) / function: \(#function) / line: \(#line)")
            }
                mainViewModel.savedBotId.accept(savedId)
        }
        
        updateLayout()
        
        
        mainViewModel.responseRelay
            .subscribe(onNext: { res in
                Service.myPrint("MainViewController - response relay") {
                    print("file: \(#file)")
                    print("function: \(#function)")
                    print("line: \(#line)")
                    print(res)
                }
                
            })
            .disposed(by: disposeBag)
        
        
        
        
        
    } // viewDidLoad
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        drawLinks(savedNode: savedNode)
    }

    
    
} // MainViewController






