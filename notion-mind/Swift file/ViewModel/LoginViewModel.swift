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

    let disposeBag = DisposeBag()
    
    
    let loginButtonTapped = PublishSubject<Void>()
    let authSuccess: PublishRelay<Bool> = PublishRelay()
    
    init() {
        authSuccess
            .subscribe(onNext: { success in
                if success {
                    print("login success")
                    //workspace id 저자
                } else {
                    print("login fail")
                }
            })
            .disposed(by: disposeBag)
        
        
        
        
        
        
    }
    
}



