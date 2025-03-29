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
    
    var node: Node? = nil

    func setNode(node: Node) {
        self.node = node
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let node = node else { return }
        
        var title = ""
        if node.icon != nil {
            title = node.icon! + node.title!
        } else {
            title = node.title ?? "제목 없음"
        }
        
        
        
        setupCustomTitleView(with: title)
        
        scrollView.delegate = self
        
        newSetUI()
        setupCloseButton()
    }

   


}





#Preview {
    NodeDetailViewController()
}
