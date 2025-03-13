//
//  LoginViewController+Ext.swift
//  notion-mind
//
//  Created by 차상진 on 3/7/25.
//

import Foundation
import UIKit
import SnapKit


extension LoginViewController {
    
   
    func setTitle() -> UILabel {
        let label = UILabel()
        label.setFont(text: "Notion Mind", style: .bold, size: 40, color: .adaptiveForeground)
        return label
    }
    
    func setImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "notionMindIcon")!.resized(to: CGSize(width: 100, height: 100)))
         imageView.contentMode = .scaleAspectFit
         return imageView
    }
    
    func setStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageView, mainTitle])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center

        return stackView
    }
    
    
    func setUI() {
        self.view.backgroundColor = .adaptiveBackground
    }
    
    
    
    func setLayout() {
        self.view.addSubview(stackView)
        self.view.addSubview(connectButton)

        stackView.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).inset(50)
            $0.top.equalTo(self.view.snp.top).inset(250)
            $0.centerX.equalTo(self.view.snp.centerX)
        }
        
        connectButton.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).inset(40)
            $0.centerX.equalTo(self.view.snp.centerX)
            $0.bottom.equalTo(self.view.snp.bottom).inset(250)
        }
        
        
        
    }
    
}
