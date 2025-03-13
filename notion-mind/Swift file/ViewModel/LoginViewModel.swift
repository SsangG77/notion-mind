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


class LoginViewModel {

    let disposeBag = DisposeBag()
    
    let loginButtonTapped = PublishSubject<Void>()
    let loginSuccess = PublishSubject<Bool>()
    
    init() {
        
        loginButtonTapped // 버튼 클릭에 의해 전달된 Observable
            .subscribe(onNext: { // 버튼 클릭 구독
                print("버튼 클릭됨. - \(AuthManager.shared.isLoggedIn())")
                
                AuthManager.shared.login() //로그인 실행
                self.loginSuccess.onNext(true) //로그인 유무 Observable의 값이 변경됨
                
            })
            .disposed(by: disposeBag)
    }
    
    
    
    
    
    
    
}

