
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
//    let mainViewModel: MainViewModel
//    private let loginViewModel: LoginViewModel
    
    
    //viewcontroller
    lazy var settingsVC = SettingViewController()
    lazy var settingNavController = UINavigationController(rootViewController: settingsVC)
    
    
    //Rx 설정
    let disposeBag = DisposeBag()
 
    
    /// 배치된 노드 rect 저장 배열
    var savedOffset: [CGRect] = []
    
    /// Rect가 지정된 node 저장
//    var savedNode: [Node] = []
    
    /// 연결 처리된 node 저장
    var linkedNodeId: [String] = []
    
    
    
    /// node 하나당 지정할 높이, 넓이
    let nodePerSize:Int = 100
    
    
//    init(viewModel: MainViewModel) {
//        self.mainViewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self

        setLayout()
        positionSettingButtton()
        
        
        if let savedId = SaveDataManager.getData(type: String.self, key: .botId) {
           
            MainViewModel.shared.savedBotId.accept(savedId)
        }
        
        updateLayout()
        
        
        MainViewModel.shared.responseRelay
            .observe(on: MainScheduler.instance)
            .map { res -> [Node] in

                self.removeNodesByDeletedIds(deleteIds: res.deleteIds)

                var localNodes = SaveDataManager.loadNodes() ?? []
                localNodes = localNodes.filter { !res.deleteIds.contains($0.id) }
                localNodes = self.setEditNodes(localNodes: localNodes, resEditNodes: res.editNodes)

                var allNodes = localNodes

                for newNode in res.newNodes {
                    let dummyView = NodeView(node: newNode)
                    self.contentView.addSubview(dummyView)
                    dummyView.snp.makeConstraints {
                        $0.leading.equalToSuperview().offset(0)
                        $0.top.equalToSuperview().offset(0)
                    }
                    self.contentView.layoutIfNeeded()
                    let size = dummyView.frame.size
                    dummyView.removeFromSuperview()

                    let rect = self.calculateNonOverlappingRect(
                        frame: self.view.frame,
                        nodeSize: size,
                        existingNodes: allNodes
                    )

                    let finalNode = Node(
                        id: newNode.id,
                        parentId: newNode.parentId,
                        icon: newNode.icon,
                        cover: newNode.cover,
                        title: newNode.title,
                        lastEdit: newNode.lastEdit,
                        property: newNode.property,
                        rect: CodableRect(from: rect)
                    )
                 

                    self.createAndAttachNodeView(node: finalNode, rect: rect)
                    allNodes.append(finalNode)
                }
                
                self.contentView.snp.remakeConstraints {
                    $0.height.equalTo(self.view.frame.height + CGFloat(self.nodePerSize * allNodes.count))
                    $0.width.equalTo(self.view.frame.width   + CGFloat(self.nodePerSize * allNodes.count))
                    $0.edges.equalTo(self.scrollView.contentLayoutGuide)
                    
//                    Service.myPrint("컨텐트뷰 업데이트 2") {
//                        print("node count : ",allNodes.count)
//                    }
                }

                return allNodes
            }
            .subscribe(onNext: { finalNodes in
                SaveDataManager.saveNodes(finalNodes)
            })
            .disposed(by: disposeBag)

        
        
        
        
        
    } // viewDidLoad
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        drawLinks(savedNode: SaveDataManager.loadNodes() ?? [])
    }

    
    
} // MainViewController






