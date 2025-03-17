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
import SafariServices



// LoginViewController
class LoginViewController: UIViewController {

    // 컴포넌트
    lazy var connectButton = CustomBorderButton(frame: .zero, type: .login)
    lazy var mainTitle = setTitle()
    lazy var imageView  = setImageView()
    lazy var stackView = setStackView()
    
    //rx 설정
    private let loginViewModel: LoginViewModel
    private let disposeBag = DisposeBag()
    
    
    //view model
    let webService = WebService()
    
    //safari view controller
    var safariViewController: SFSafariViewController?
    
    init(viewModel: LoginViewModel) {
        self.loginViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("CloseSafariViewController"), object: nil)
    }

// viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
       
        eventHandling()
       
        
    }
// viewDidLoad
    
    private func eventHandling() {
        connectButton.rx.tap //로그인 버튼 클릭하여 이벤트 방출
            .subscribe(onNext: {
                self.openNotionAuth()
            })
            .disposed(by: disposeBag)
        
        
        self.loginViewModel.authSuccess // 로그인 성공 이벤트 방출됨
            .observe(on: MainScheduler.instance) //
            .subscribe(onNext: { [weak self] success in //
                guard let self = self else { return }
                self.closeSafari()
                if success {
                    self.navigateToMain()
                } else {
                    print("로그인 실패 알림창 띄우기")
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    
  
   
    
}
// LoginViewController






#if DEBUG

import SwiftUI


struct LoginVCPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewCOntroller: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        LoginViewController(viewModel:LoginViewModel())
    }
    
}

struct LoginVCPresentablePreviews: PreviewProvider {
    static var previews: some View {
        LoginVCPresentable()
            .ignoresSafeArea()
    }
}



#endif
