//
//  ConnectNotionButton+Ext.swift
//  notion-mind
//
//  Created by 차상진 on 3/7/25.
//

import Foundation
import UIKit



//MARK: - action 설정
extension CustomBorderButton {
    
    
    @objc func buttonTouchedDown() {
        stackView.backgroundColor = UIColor.black
        label.textColor = UIColor.white
    }

    @objc func buttonReleased() {
        stackView.backgroundColor = UIColor(hexCode: "F1F1F1")
        label.textColor = UIColor.black
    }

}


//MARK: - 컴포넌트 설정
extension CustomBorderButton {
    
    func setLabel(title: String) -> UILabel {
        let label = UILabel()
        label.setFont(text: "Connect to Notion", style: .regular, size: 20)
        return label
    }
    
    func setImage() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "notion")!.resized(to: CGSize(width: 34, height: 34)))
         imageView.contentMode = .scaleAspectFit
         return imageView
    }
    
    func setStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = -30
        stackView.alignment = .center
        stackView.backgroundColor =  UIColor(hexCode: "F1F1F1")
        stackView.layer.cornerRadius = 11
        stackView.layoutMargins = UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 40)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.arrangedSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        stackView.isUserInteractionEnabled = false
        return stackView
    }
    
    
}


//MARK: - UI 설정
extension CustomBorderButton {
    
    func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor =  UIColor.black // 버튼 배경 설정
        layer.cornerRadius = 16 // 테두리 곡률 설정
        
        stackView.addArrangedSubview(notionImage)
        stackView.addArrangedSubview(label)
        
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        
        //버튼 높이 설정
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 70)
        ])
        
    }
    
}

