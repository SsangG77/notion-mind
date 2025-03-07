//
//  ConnectNotionself.swift
//  notion-mind
//
//  Created by 차상진 on 3/5/25.
//

import Foundation
import UIKit



class CustomBorderButton: UIButton {
    
    lazy var label:UILabel = self.setLabel(title: "Connect to Notion")
    lazy var notionImage: UIImageView = self.setImage()
    lazy var stackView: UIStackView = self.setStackView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
       
        addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchDragExit])
    }

 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}










//MARK: - preview
#if DEBUG

import SwiftUI
import UIKit


class ConnectButtonVC: UIViewController {
    

    let button = CustomBorderButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -250),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
    }

}


struct ConnectNotionButtonPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewCOntroller: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ConnectButtonVC()
    }
    
}

struct ConnectNotionButtonPresentablePreviews: PreviewProvider {
    static var previews: some View {
        ConnectNotionButtonPresentable()
            .ignoresSafeArea()
    }
}



#endif
