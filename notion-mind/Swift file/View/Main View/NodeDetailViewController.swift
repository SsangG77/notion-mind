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
    lazy var scrollView     = setScrollView()
    lazy var contentView    = setContentView()
    lazy var propertyView   = setPropertyView()
    lazy var imageView      = setCoverView()
    // rx
    let disposeBag = DisposeBag()
    
    // sticky header image
    let headerHeight: CGFloat = 200
    var headerHeightConstraint: NSLayoutConstraint!
    
    
//    var node: Node? = nil
    var node: Node? = Node(id: "id 1", parentId: "preant_id", icon: "🥬", cover: "https://images.unsplash.com/photo-1742387436246-a7288481be39?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "1 node", lastEdit: Date(), property: [
        Property(name: "항목", type: "relation", value: [
            ValueType(id: UUID().uuidString, name: "id 2", color: "clear"),
            ValueType(id: UUID().uuidString, name: "id 3", color: "clear"),
        ]),
       
        Property(name: "pages", type: "relation", value: [
            ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
            ValueType(id: UUID().uuidString, name: "id 5", color: "clear"),
        ]),
        Property(name: "Tech", type: "select", value: [
            ValueType(id: UUID().uuidString, name: "rxswift", color: "red")
        ]),
        Property(name: "pages", type: "relation", value: [
            ValueType(id: UUID().uuidString, name: "id 4", color: "clear"),
            ValueType(id: UUID().uuidString, name: "id 5", color: "clear"),
        ]),
        Property(name: "Tech", type: "multi_select", value: [
            ValueType(id: UUID().uuidString, name: "rxswift", color: "red"),
            ValueType(id: UUID().uuidString, name: "uikit", color: "green"),
            ValueType(id: UUID().uuidString, name: "mvvm", color: "blue"),
        ]),
        Property(name: "Done", type: "checkbox", value: [
            ValueType(id: UUID().uuidString, name: "false", color: "clear"),
        ]),
        Property(name: "Done", type: "checkbox", value: [
            ValueType(id: UUID().uuidString, name: "false", color: "clear"),
        ])
    ], rect: CodableRect(from: CGRect()))
    
    
    func setNode(node: Node) {
        self.node = node
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let node = node else { return }
        
        setupCustomTitleView(with: node.title ?? "title 없음")
        
        scrollView.delegate = self
        
        newSetUI()
        setupCloseButton()
    }

    private func setupCustomTitleView(with title: String) {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true

        let titleLabel = UILabel()
        titleLabel.setFont(text: title, style: .bold, size: 20, color: .black)

        blurView.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8) // 블러뷰 안에서 여백
        }

        blurView.frame = CGRect(x: 0, y: 0,
                                   width: titleLabel.intrinsicContentSize.width + 24,
                                   height: titleLabel.intrinsicContentSize.height + 16)

        navigationItem.titleView = blurView
    }


}





#Preview {
    NodeDetailViewController()
}
