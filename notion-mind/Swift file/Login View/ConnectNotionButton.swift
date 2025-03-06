//
//  ConnectNotionself.swift
//  notion-mind
//
//  Created by 차상진 on 3/5/25.
//

import Foundation
import UIKit


//MARK: - 바꾼 후
class CustomBorderButton: UIButton {
    
    private lazy var label:UILabel = self.setLabel(title: "Connect to Notion")
    
    private lazy var notionImage: UIImageView = self.setImage()
    
    private lazy var stackView: UIStackView = self.setStackView()
    

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






//MARK: - action 설정
extension CustomBorderButton {
    
    
    @objc private func buttonTouchedDown() {
        stackView.backgroundColor = UIColor.black
        label.textColor = UIColor.white
    }

    @objc private func buttonReleased() {
        stackView.backgroundColor = UIColor(hexCode: "F1F1F1")
        label.textColor = UIColor.black
    }

}


//MARK: - 컴포넌트 설정
extension CustomBorderButton {
    
    func setLabel(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Connect to Notion"
        label.font = UIFont(name: "InriaSans-Regular", size: 20)
        return label
    }
    
    func setImage() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "notion")!.resized(to: CGSize(width: 34, height: 34)))
         imageView.translatesAutoresizingMaskIntoConstraints = false
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
