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
//import UIViewSeparator


class NodeDetailViewController: UIViewController {
    
    
    // component
    lazy var graphContentView = setGraphContentView()
    
    
    //노드 하나당 사이즈
    let nodePerSize:Int = 100
    
    // id들 저장
    var relationNodes:[Node] = []
    
    
    /// Rect가 지정된 node 저장
    var savedNode: [Node] = []
    
    
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
        ])
    ], rect: CGRect())
    
    
    
    
    func setNode(node: Node) {
        self.node = node
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = node?.title
        setupCloseButton()
        guard let node = node else { return }
        setUI(node: node)
        
        MainViewModel.shared.nodesRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] nodes in
                guard let self = self else { return }
                
                relationNodes = nodes.compactMap { element in
                    let relationProps = element.property.filter { $0.type == .relation }
                    
                    for prop in relationProps {
                        guard let propValue = prop.value as? [String], propValue.contains(node.id) else {
                            continue
                        }
                        return element
                    }
                    return nil
                }
            })
            .disposed(by: disposeBag)
        
        
    }
}



extension NodeDetailViewController {
    
    func setNodeInGraph(frame: CGRect, node: Node, nodesCount: Int) -> Node {
        let frameHeight           = frame.height
        let frameWidth            = frame.width
        
        let nodeView = NodeView(node: node)
        
        graphContentView.addSubview(nodeView)
        
        nodeView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        self.graphContentView.layoutIfNeeded()
        
        let nodeHeight = nodeView.frame.height
        let nodeWidth = nodeView.frame.width
        
        var randomX: CGFloat
        var randomY: CGFloat
        var newRect: CGRect
        
        let inset: CGFloat = CGFloat((nodePerSize/20) * nodesCount)
        
        repeat {
            
            //(x,y)를 지정할 범위를 정함
            randomX = CGFloat.random(in: inset...(frameWidth + CGFloat(nodePerSize * nodesCount) - nodeWidth - inset))
            randomY = CGFloat.random(in: inset...(frameHeight + CGFloat(nodePerSize * nodesCount) - nodeHeight - inset))
            
            //(x,y, width, height)를 생성해서 모든 node rect배열에 저장
            newRect = CGRect(x: randomX, y: randomY, width: nodeWidth, height: nodeHeight)
        }
        while savedNode.contains(where: { $0.rect.intersects(newRect) })
        
        let newNode = Node(id: node.id, icon: node.icon, cover: node.cover, title: node.title, property: node.property, rect: newRect)
                
       
        nodeView.snp.updateConstraints {
            $0.leading.equalToSuperview().offset(randomX)
            $0.top.equalToSuperview().offset(randomY)
        }
        
        
        
        
        return newNode
    }
}


extension NodeDetailViewController {
    func setUI(node: Node) {
        self.view.backgroundColor = .white
        
        let scrollView = setScrollView()
        let contentView = setContentView()
        let propertyView = setPropertyView(node.property)
        let graphView = setGraphView()
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        scrollView.addSubview(contentView)
        contentView.addSubview(graphView)
        contentView.addSubview(propertyView)
        graphView.addSubview(graphContentView)
        
        
        contentView.snp.makeConstraints {
            
//            $0.height.equalTo(1000) //임시 높이값
            
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
            
            $0.bottom.equalTo(graphView.snp.bottom)
        }
        
        
        propertyView.snp.makeConstraints {
            
//            $0.height.equalTo(200)
            
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        graphView.snp.makeConstraints {
            
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(propertyView.snp.bottom).inset(-25)
            $0.height.equalTo(1350)
        }
        
    }
}


extension NodeDetailViewController {
    
    
    func setScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
        return scrollView
    }
    
    func setContentView() -> UIView {
        let contentView  = UIView()
        contentView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
        
        return contentView
    }
    
    
    func setPropertyView(_ props: [Property<Any>]) -> UIStackView {
        let stackView = UIStackView()
//        stackView.backgroundColor = .gray
        stackView.axis = .vertical
        stackView.spacing = 5
        
        
        for prop in props {
            
            let hstack = UIStackView()
            hstack.axis = .horizontal
            hstack.distribution = .fill
            hstack.spacing = 15
            hstack.backgroundColor = .cyan
            
            
            
            let propName = UILabel()
            propName.text = prop.name
            propName.textColor = UIColor.init(hexCode: "787773")
            
            let propValue = UILabel()
            propValue.text = "prop value"
            
            
            hstack.addArrangedSubview(propName)
            hstack.addArrangedSubview(propValue)
            hstack.snp.makeConstraints {
                $0.height.greaterThanOrEqualTo(45)
            }
            propValue.snp.makeConstraints {
                $0.width.equalTo(propName.snp.width).multipliedBy(2.2)
            }
            
            stackView.addArrangedSubview(hstack)
            
        }
        
        
        stackView.separator(color: UIColor(hexCode: "787773") , height: 2, spacing: 12)
        
        return stackView
    }
    
    func setGraphContentView() -> UIView {
        let innerView = UIView()
        innerView.backgroundColor = .brown
        
        innerView.snp.makeConstraints {
            $0.height.width.equalTo(400)
        }
        
        return innerView
    }
    
    
    func setGraphView() -> UIScrollView {
        let view = UIScrollView()
        view.backgroundColor = .green
        
       
        
        
        
        
        
        
        return view
    }
    
    
}




// 닫기 버튼 세팅
extension NodeDetailViewController {
    func setupCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeSettings))
    }
    
    @objc func closeSettings() {
        dismiss(animated: true, completion: nil)
    }
}





extension UIView {
    
    func separator(color: UIColor = .black, height: CGFloat = 1, spacing: CGFloat = 0) {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = color
        line.layer.cornerRadius = 3
        self.addSubview(line)
        NSLayoutConstraint.activate([
              line.heightAnchor.constraint(equalToConstant: height),
              line.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              line.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: spacing) // 기본적으로 하단에 배치
          ])
    }
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
