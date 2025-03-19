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
    // rx
    let disposeBag = DisposeBag()
    
    
    
    
    
//    var node: Node? = nil
    var node: Node? = Node(id: "id 1", parrentId: "", icon: "🥬", cover: nil, title: "1 node", property: [
        Property(name: "항목", type: .relation, value: [
            ValueType(id: UUID().uuidString, name: "id 2", color: "clear"),
            ValueType(id: UUID().uuidString, name: "id 3", color: "clear"),
        ]),
        Property(name: "pages", type: .relation, value: [
            ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
            ValueType(id: UUID().uuidString, name: "id 5", color: "clear"),
        ]),
        Property(name: "Tech", type: .multi_select, value: [
            
            ValueType(id: UUID().uuidString, name: "rxswift", color: "red"),
            ValueType(id: UUID().uuidString, name: "uikit", color: "green"),
            ValueType(id: UUID().uuidString, name: "mvvm", color: "blue"),
        ]),
        Property(name: "Done", type: .checkbox, value: [
            ValueType(id: UUID().uuidString, name: "false", color: "clear"),
        ])
    ], rect: CGRect())
    
    
    func setNode(node: Node) {
        self.node = node
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let node = node else { return }
        title = node.title
        
        
        
        setUI()
        setupCloseButton()
    }// viewDidLoad
    
    
    
}






