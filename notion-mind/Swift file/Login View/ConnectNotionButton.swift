//
//  ConnectNotionself.swift
//  notion-mind
//
//  Created by 차상진 on 3/5/25.
//

import Foundation
import UIKit

class ConnectNotionButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
               addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchDragExit])
        
       
        
    }
    
    @objc private func buttonTouchedDown() {
            backgroundColor = UIColor.black // 터치 시 회색으로 변경
        }

        @objc private func buttonReleased() {
            backgroundColor = UIColor(hexCode: "F1F1F1") // 원래 색상으로 복구
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//UI setting
extension ConnectNotionButton {
    func setupUI() {
        setTitle("Connect to Notion", for: .normal) // 버튼의 타이틀 설정
        titleLabel?.font = UIFont(name: "InriaSans-Regular", size: 20) // 폰트 설정
        backgroundColor =  UIColor(hexCode: "F1F1F1") // 버튼 배경 설정
        
        
        
        setTitleColor(.black, for: .normal) // 타이틀 컬러 설정
        setTitleColor(.white, for: .highlighted) // 타이틀 컬러 설정
        layer.cornerRadius = 15 // 테두리 곡률 설정
        layer.borderWidth = 4 // 테두리 두께 설정
        layer.borderColor = UIColor.black.cgColor
        
        let imageView = UIImageView(image: UIImage(named: "notion"))
        imageView.contentMode = .scaleAspectFit

        imageView.frame = CGRect(x: 20, y: 15, width: 30, height: 30) // 원하는 크기 설정
        self.addSubview(imageView)

        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)

    }
}




#if DEBUG

import SwiftUI


struct ConnectNotionButtonPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewCOntroller: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ViewController()
    }
    
}

struct ConnectNotionButtonPresentablePreviews: PreviewProvider {
    static var previews: some View {
        MainVCPresentable()
            .ignoresSafeArea()
    }
}



#endif
