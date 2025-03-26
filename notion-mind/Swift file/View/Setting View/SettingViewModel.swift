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
    
    
    //viewModel
    let loginViewModel = LoginViewModel()
//    let mainViewModel = MainViewModel()
    
    init() {
        
        logoutButtonTapped
            .subscribe(onNext: {
                SaveDataManager.setData(value: false, key: .isLogin)
                SaveDataManager.removeData(key: .botId)
                
                let loginVC = LoginViewController(viewModel: self.loginViewModel)
                UIApplication.shared.windows.first?.rootViewController = loginVC
                
            })
            .disposed(by: disposeBag)
        
    }
    
}
