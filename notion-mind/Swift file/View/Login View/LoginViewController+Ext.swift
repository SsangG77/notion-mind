//
//  LoginViewController+Ext.swift
//  notion-mind
//
//  Created by 차상진 on 3/7/25.
//

import Foundation
import UIKit



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
        stackView.arrangedSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
    
    
    func setUI() {
        self.view.backgroundColor = .adaptiveBackground
    }
    
    
    
    func setLayout() {
        self.view.addSubview(stackView)
        self.view.addSubview(connectButton)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            connectButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            connectButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            connectButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -250)
            
        ])
    }
    
}
