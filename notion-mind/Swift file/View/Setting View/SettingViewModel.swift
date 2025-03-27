//
//  SettingViewModel.swift
//  notion-mind
//
//  Created by 차상진 on 3/18/25.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import RxCocoa


class SettingViewModel {
    
    //rx
    let logoutButtonTapped = PublishRelay<Void>()
    let disposeBag = DisposeBag()
    
    
    
    init() {
        
        logoutButtonTapped
            .subscribe(onNext: {
                SaveDataManager.setData(value: false, key: .isLogin)
                SaveDataManager.removeData(key: .botId)
                LoginViewModel.shared.authSuccess.accept(false)

                let loginVC = LoginViewController()

                LoginViewModel.shared.changeRootViewController(loginVC)
            })
            .disposed(by: disposeBag)

        
    }
    
}
