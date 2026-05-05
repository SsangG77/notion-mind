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
    private let disposeBag = DisposeBag()
    
    //view model
//    let loginViewModel: LoginViewModel
    let webService = WebService()
    
    //safari view controller
    var safariViewController: SFSafariViewController?
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("CloseSafariViewController"), object: nil)
    }

// viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = formatter.string(from: now)

        
        setUI()
        setLayout()
       
        connectButton.rx.tap //로그인 버튼 클릭하여 이벤트 방출
            .subscribe(onNext: {
                self.openNotionAuth()
            })
            .disposed(by: disposeBag)
        
        

        LoginViewModel.shared.authSuccess // 로그인 성공 이벤트 방출됨
            .compactMap { $0 }
            .observe(on: MainScheduler.instance) //
            .subscribe(onNext: { [weak self] success in //
                guard let self = self else { return }
                if success {
                    SaveDataManager.setData(value: true, key: .isLogin)
                    self.navigateToMain()
                } else {
                    print("로그인 실패 알림창 띄우기")
                }
            })
            .disposed(by: disposeBag)
       
        
    }
// viewDidLoad
    
}
// LoginViewController




