//
//  ConnectNotionself.swift
//  notion-mind
//
//  Created by 차상진 on 3/5/25.
//

import Foundation
import UIKit
import SnapKit


enum logType {
    case login, logout
}


class CustomBorderButton: UIButton {
    
    lazy var label:UILabel = UILabel()
    lazy var notionImage: UIImageView = self.setImage()

    lazy var innerView = self.setInnerView()
    
    var color: UIColor = .blue

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, type: logType) {
        super.init(frame: frame)
        
        switch type {
        case .login:
            color = UIColor.black
            label = self.setLabel(title: "Connect to Notion")
            setupUI(type: type)
            break
        case .logout:
            color = UIColor.red
            label = self.setLabel(title: "log out")
            label.textColor = .red
            setupUI(type: type)
            break
        }
        
        
       
        addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchDragExit])
    }

 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







//
//
//
////MARK: - preview
//#if DEBUG
//
//import SwiftUI
//import UIKit
//
//
//class ConnectButtonVC: UIViewController {
//    
//
//    let button = CustomBorderButton(frame: .zero, type: .login)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.view.addSubview(button)
//        
//        button.snp.makeConstraints {
//            $0.leading.equalTo(self.view.snp.leading).inset(50)
//            $0.bottom.equalTo(self.view.snp.bottom).inset(250)
//            $0.centerX.equalTo(self.view.snp.centerX)
//        }
//        
//    }
//
//}
//
//
//struct ConnectNotionButtonPresentable: UIViewControllerRepresentable {
//    func updateUIViewController(_ uiViewCOntroller: UIViewControllerType, context: Context) {
//        
//    }
//    
//    func makeUIViewController(context: Context) -> some UIViewController {
//        ConnectButtonVC()
//    }
//    
//}
//
//struct ConnectNotionButtonPresentablePreviews: PreviewProvider {
//    static var previews: some View {
//        ConnectNotionButtonPresentable()
//            .ignoresSafeArea()
//    }
//}
//
//
//
//#endif
