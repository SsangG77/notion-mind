//
//  Node.swift
//  notion-mind
//
//  Created by 차상진 on 3/8/25.
//

import Foundation
import UIKit
import SnapKit




//배경이 되는 화면, 내부 컨텐츠 화면 겹치기
// 내부 컨텐츠 -> 페이지 아이콘, 타이틀, 데이터베이스 id(색 지정)

class NodeView: UIView {
    var node: Node
    
    
    // vc
    let nodeDetailVC: NodeDetailViewController = NodeDetailViewController()
    
    
    
    //component
    var innerView: UIView
    
    
    
    init(node: Node, frame: CGRect = .zero) {
        self.node = node
        self.innerView = NodeView.createInnerView(node: node) //추가
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNewNode(node: Node) {
        self.node = node
//        self.innerView = NodeView.createInnerView(node: node)
    }
    
}


//MARK: - preview
#if DEBUG

import SwiftUI
import UIKit


class NodeViewVC: UIViewController {
    
    let node = Node(id: "id1", parentId: "", icon: nil, cover: nil, title: "ios", lastEdit: Date(), property: [], rect:  CodableRect(from: CGRect()))

    override func viewDidLoad() {
        super.viewDidLoad()
        let nodeView = NodeView(node: self.node)
        
        self.view.addSubview(nodeView)
        
        nodeView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
       
        
    }

}


struct NodeViewPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewCOntroller: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        NodeViewVC()
    }
    
}

struct NodeViewPresentablePreviews: PreviewProvider {
    static var previews: some View {
        NodeViewPresentable()
            .ignoresSafeArea()
    }
}



#endif
