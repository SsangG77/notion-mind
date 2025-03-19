//
//  NodeDetailViewController+Ext.swift
//  notion-mind
//
//  Created by 차상진 on 3/15/25.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import RxCocoa
import UIViewSeparator



//MARK: - set ui
extension NodeDetailViewController {
    
    func setUI() {
        self.view.backgroundColor = .white
        
        
        self.view.addSubview(scrollView) //1
        scrollView.addSubview(contentView) //2
        
        
        
        scrollView.snp.makeConstraints { //3
            $0.edges.equalToSuperview()
        }
        
        
        contentView.addSubview(propertyView) //4
        
        
        contentView.snp.makeConstraints {
               $0.width.equalTo(scrollView.frameLayoutGuide.snp.width) // 스크롤뷰의 실제 프레임 너비와 같게 설정
               $0.top.bottom.equalTo(scrollView.contentLayoutGuide) // 상하만 콘텐츠 가이드에 맞춤
               $0.leading.trailing.equalTo(scrollView.frameLayoutGuide) // 좌우는 프레임 가이드에 맞춤
           }
        
        propertyView.snp.makeConstraints { //5
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        
        
        
    }// setUI
    
}


//MARK: - set component
extension NodeDetailViewController {
    
    
    func setScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.alwaysBounceVertical = true
            scrollView.alwaysBounceHorizontal = false
        scrollView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
//        scrollView.backgroundColor = .blue
        
        
        
        return scrollView
    }
    
    func setContentView() -> UIView {
        let contentView  = UIView()
        contentView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
        
        return contentView
    }
    
    
    func setPropertyView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
      
        
        guard let node = node else {
            print("node property 할당 안됨")
            return stackView
        }
        let props = node.property
        for prop in props {
            
            let hstack = UIStackView()
            hstack.axis = .horizontal
            hstack.alignment = .top
            hstack.distribution = .fill
            hstack.spacing = 10
            
            let propName = UILabel()
            propName.setFont(text: prop.name, size: 18, color: UIColor.init(hexCode: "787773"))
            let propValue = nodeDetailViewModel.propToView(prop: prop)
            
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
        
        
        stackView.separator(color: UIColor(hexCode: "787773") , height: 2, spacing: 15)
        
        return stackView
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
