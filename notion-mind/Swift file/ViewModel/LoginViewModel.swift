//
//  LoginViewModel.swift
//  notion-mind
//
//  Created by 차상진 on 3/7/25.
//

import Foundation
import UIKit
import RxSwift
import RxRelay


struct LoginResult {
    var isSuccess: Bool
}


class LoginViewModel {
    
    static let shared = LoginViewModel()
    
    
    
    let disposeBag = DisposeBag()
    let loginButtonTapped = PublishSubject<Void>()
    let authSuccess = BehaviorRelay<Bool?>(value: nil)

    
    /// 뷰컨트롤러 애니메이션 설정하기
    /// - Parameters:
    ///   - vc: 애니메이션을 설정할 뷰 컨트롤러
    ///   - animated: 애니메이션 설정 유무
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }

        if animated {
            UIView.transition(with: window,
                              duration: 0.4,
                              options: [.transitionCrossDissolve],
                              animations: {
                                  window.rootViewController = vc
                              })
        } else {
            window.rootViewController = vc
        }

        window.makeKeyAndVisible()
    }

    
}



