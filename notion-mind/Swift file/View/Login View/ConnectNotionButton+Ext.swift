//
//  ConnectNotionButton+Ext.swift
//  notion-mind
//
//  Created by 차상진 on 3/7/25.
//

import Foundation
import UIKit
import SnapKit



//MARK: - action 설정
extension CustomBorderButton {
    
    
    @objc func buttonTouchedDown() {
        innerView.backgroundColor = color
        label.textColor = UIColor(hexCode: "F1F1F1")
    }

    @objc func buttonReleased() {
        innerView.backgroundColor = UIColor(hexCode: "F1F1F1")
        label.textColor = color
    }

}


//MARK: - 컴포넌트 설정
extension CustomBorderButton {
    
    
    func setLabel(title: String) -> UILabel {
        let label = UILabel()
        label.setFont(text: title, style: .regular, size: 20)
        return label
    }
    
    func setImage() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "notion")!.resized(to: CGSize(width: 34, height: 34)))
         imageView.contentMode = .scaleAspectFit
         return imageView
    }
    
    
    func setInnerView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexCode: "F1F1F1")
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 11
        
        return view
    }
    
    
}


//MARK: - UI 설정
extension CustomBorderButton {
    
    func setupUI(type: logType) {
        self.backgroundColor =  color // 버튼 배경 설정
        layer.cornerRadius = 16 // 테두리 곡률 설정
        //버튼 높이 설정
        self.snp.makeConstraints {
            $0.height.equalTo(70)
        }
        
        
        if type == .login {
            innerView.addSubview(notionImage)
        }
        innerView.addSubview(label)
        
        addSubview(innerView)
        
        innerView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(3)
            $0.trailing.bottom.equalToSuperview().inset(10)
        }
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        if type == .login {
            
            notionImage.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(label.snp.leading).inset(-10)
            }
        }
        
        
        
        
    }
    
}





//MARK: - preview
#if DEBUG

import SwiftUI
import UIKit


class ConnectButtonVC: UIViewController {
    

    let button = CustomBorderButton(frame: .zero, type: .login)
    let logout = CustomBorderButton(frame: .zero, type: .logout)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(button)
        self.view.addSubview(logout)
        
        button.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).inset(50)
            $0.top.equalTo(self.view.snp.top).inset(250)
            $0.centerX.equalTo(self.view.snp.centerX)
        }
        
        logout.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).inset(50)
            $0.centerX.equalTo(self.view.snp.centerX)
            $0.bottom.equalTo(self.view.snp.bottom).inset(250)
        }
        
        
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
