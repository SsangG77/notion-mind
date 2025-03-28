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
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Observable Properties
    let databases = BehaviorRelay<[DatabaseModel]>(value: [])
    let databaseColors = BehaviorRelay<[String: String]>(value: [:])
    let logoutButtonTapped = PublishRelay<Void>()
    
    // MARK: - Initialization
    init() {
        setupBindings()
        loadDatabaseColors()
    }
    
    // MARK: - Private Methods
    private func setupBindings() {
        logoutButtonTapped
            .subscribe(onNext: { [weak self] in
                self?.handleLogout()
            })
            .disposed(by: disposeBag)
    }
    
    private func loadDatabaseColors() {
        if let colors = UserDefaults.standard.dictionary(forKey: "databaseColors") as? [String: String] {
            databaseColors.accept(colors)
        }
    }
    
    private func handleLogout() {
//        UserDefaults.standard.set(false, forKey: "isLogin")
//        UserDefaults.standard.removeObject(forKey: "botId")
//        // 로그아웃 후 로그인 화면으로 이동하는 로직은 ViewController에서 처리
        
        SaveDataManager.setData(value: false, key: .isLogin)
        SaveDataManager.removeData(key: .botId)
        LoginViewModel.shared.authSuccess.accept(false)

        let loginVC = LoginViewController()

        LoginViewModel.shared.changeRootViewController(loginVC)
        
        
        
    }
    
    // MARK: - Public Methods
    func fetchDatabaseList() {
        guard let url = URL(string: "https://8b62-58-226-117-28.ngrok-free.app/data/database") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil else { return }
            
            do {
                let databases = try JSONDecoder().decode([DatabaseModel].self, from: data)
                DispatchQueue.main.async {
                    self.databases.accept(databases)
                }
            } catch {
                print("Error decoding database list: \(error)")
            }
        }.resume()
    }
    
    func getOrCreateColor(for databaseId: String) -> UIColor {
        let colors = databaseColors.value
        
        if let colorHex = colors[databaseId] {
            return UIColor(hexCode: colorHex)
        } else {
            let randomColor = UIColor(
                red: CGFloat.random(in: 0...1),
                green: CGFloat.random(in: 0...1),
                blue: CGFloat.random(in: 0...1),
                alpha: 1.0
            )
            
            var newColors = colors
            newColors[databaseId] = randomColor.toHexString()
            databaseColors.accept(newColors)
            UserDefaults.standard.set(newColors, forKey: "databaseColors")
            
            return randomColor
        }
    }
}
