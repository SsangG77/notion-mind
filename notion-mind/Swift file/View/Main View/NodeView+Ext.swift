//
//  NodeView+Ext.swift
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





//MARK: -  컴포넌트
extension NodeView {
    
    static func createInnerView(node: Node) -> UIView {
        let innerView = UIView()
        
        // 초기 색상 설정
        if let parentId = node.parentId {
            let color = SettingViewModel().getOrCreateColor(for: parentId)
            innerView.backgroundColor = color
        } else {
            innerView.backgroundColor = .white // 기본 색상
        }
        
        innerView.layer.cornerRadius = 10
        
        let label = UILabel()
        
        var iconString = ""
        var titleString = ""
        if let icon = node.icon {
            iconString = icon
        }
        if let title = node.title {
            titleString = title
        }

        label.text = "\(iconString) \(titleString)"
        label.textAlignment = .center
        label.changeTextColorByBG(for: innerView.backgroundColor ?? .white)
        label.font = UIFont().setFontStyle(style: .regular, size: 30)
        innerView.addSubview(label)
        
        
        label.snp.makeConstraints {
            $0.center.equalTo(innerView.snp.center)
            $0.edges.equalTo(innerView.snp.edges).inset(6)
        }
        innerView.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(150)
            $0.height.equalTo(60)
        }
            
        
        return innerView
    }
    
    

}



//MARK: - setUI
extension NodeView {
    
   
     func setupUI() {
        
        self.addSubview(innerView)
        self.layer.cornerRadius = 19
        self.backgroundColor = .black
        
        innerView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).inset(5)
            $0.leading.equalTo(self.snp.leading).inset(5)
            $0.bottom.equalTo(self.snp.bottom).inset(12)
            $0.trailing.equalTo(self.snp.trailing).inset(12)
        }
         
//         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//         self.addGestureRecognizer(tapGesture)
    }
    
    
//    @objc func handleTap() {
//        print("\(String(describing: node.title)) Tap!")
//        
//        let navController = UINavigationController(rootViewController: nodeDetailVC) // 네비게이션 컨트롤러 포함
//        navController.modalPresentationStyle = .fullScreen // 전체 화면으로 표시
//        present(navController, animated: true, completion: nil)
//        
//    }
}

extension NodeView {
    // innerView 색상 업데이트
    func updateInnerViewColor(_ color: UIColor) {
        innerView.backgroundColor = color
        // 텍스트 색상도 배경색에 맞게 업데이트
        if let label = innerView.subviews.first as? UILabel {
            label.changeTextColorByBG(for: color)
        }
    }
}

