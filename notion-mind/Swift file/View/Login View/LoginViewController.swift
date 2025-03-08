//
//  ViewController.swift
//  notion-mind
//
//  Created by 차상진 on 3/5/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

// LoginViewController
class LoginViewController: UIViewController {

    // 컴포넌트
    lazy var connectButton = CustomBorderButton()
    lazy var mainTitle = setTitle()
    lazy var imageView  = setImageView()
    lazy var stackView = setStackView()
    
    //rx 설정
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()

    
    
    
// viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        
        
        connectButton.rx.tap //로그인 버튼 클릭하여 이벤트 방출
            .bind(to: loginViewModel.loginButtonTapped)
            .disposed(by: disposeBag)
        
        
        self.loginViewModel.loginSuccess // 로그인 성공 이벤트 방출됨
            .observe(on: MainScheduler.instance) //
            .subscribe(onNext: { [weak self] success in //
                if success {
                    self?.navigateToMain()
                }
            })
            .disposed(by: disposeBag)
        
        
        
        
        
    }
// viewDidLoad
    
    
    private func navigateToMain() {
        let mainVC = MainViewController()
        UIApplication.shared.windows.first?.rootViewController = mainVC
    }
   
    
}
// LoginViewController





#if DEBUG

import SwiftUI


struct MainVCPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewCOntroller: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        LoginViewController()
    }
    
}

struct MainVCPresentablePreviews: PreviewProvider {
    static var previews: some View {
        MainVCPresentable()
            .ignoresSafeArea()
    }
}



#endif
