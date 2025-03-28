//
//  SettingViewController.swift
//  notion-mind
//
//  Created by 차상진 on 3/12/25.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxRelay
import RxCocoa

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxRelay
import RxCocoa

class SettingViewController: UIViewController {
    
    let webService = WebService()
    
    // view model
    let settingViewModel = SettingViewModel()
    
    // 컴포넌트
    lazy var scrollView = setScrollView()
    lazy var selectedDBTitle = setSelectedDatabaseTitle()
    lazy var logoutButton = CustomBorderButton(frame: .zero, type: .logout)
    lazy var stackDBView = setDBListView()
    
    // rx
    let disposeBag = DisposeBag()
    
    // UserDefaults keys
//    private let databaseColorsKey = "databaseColors"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(hexCode: "DFDFDF")
        title = "Setting"
        setupCloseButton() // setting close button
        setUI()
        
        fetchDatabaseList()
        
        logoutButton.rx.tap
            .bind {
                self.settingViewModel.logoutButtonTapped.accept($0)
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchDatabaseList() {
        guard let url = URL(string: webService.database) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil else { return }
            
            do {
                let databases = try JSONDecoder().decode([DatabaseModel].self, from: data)
                DispatchQueue.main.async {
                    // 기존의 모든 arrangedSubview 제거
                    self.stackDBView.arrangedSubviews.forEach { $0.removeFromSuperview() }
                    
                    // 새로운 데이터베이스 목록 추가
                    databases.forEach { database in
                        self.stackDBView.addArrangedSubview(self.setSingleDBView(database: database))
                    }
                }
            } catch {
                print("Error decoding database list: \(error)")
            }
        }.resume()
    }
    
//    private func getOrCreateColor(for databaseId: String) -> UIColor {
//        if let existingColor = settingViewModel.getOrCreateColor(for: databaseId) {
//            return existingColor
//        } else {
//            // 새로운 랜덤 색상 생성
//            let randomColor = UIColor(
//                red: CGFloat.random(in: 0...1),
//                green: CGFloat.random(in: 0...1),
//                blue: CGFloat.random(in: 0...1),
//                alpha: 1.0
//            )
//            var colors = settingViewModel.getDatabaseColors()
//            colors[databaseId] = randomColor.toHexString()
//            settingViewModel.saveDatabaseColors(colors)
//            return randomColor
//        }
//    }
}

//MARK: - set Layout
extension SettingViewController {
    
    func setUI() {
        view.backgroundColor = UIColor(hexCode: "DFDFDF")
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(selectedDBTitle)
        selectedDBTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(30)
        }

        scrollView.addSubview(stackDBView)
        stackDBView.snp.makeConstraints {
            $0.top.equalTo(selectedDBTitle.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }

        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(50)
        }
        
    }

}


// components
extension SettingViewController {
    
    
    //scrollview
    func setScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
       
        //임시
//        scrollView.backgroundColor = .red
        
        return scrollView
    }
    
    
    //selected database title
    func setSelectedDatabaseTitle() -> UILabel {
        let title = UILabel()
        title.setFont(text: "Selected Database", size: 23, color: UIColor(hexCode: "2D2D2D"))
        return title
    }
    
    
    // single database view
    func setSingleDBView(database: DatabaseModel) -> UIView {
        let dbView = UIView()
        let color = settingViewModel.getOrCreateColor(for: database.id)
        dbView.backgroundColor = color
        dbView.layer.cornerRadius = 12
        dbView.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        let label = UILabel()
        label.setFont(text: database.title, size: 20)
        
        dbView.addSubview(label)
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        return dbView
    }
    
    
    
    // database view
    func setDBListView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
//        stackView.backgroundColor = .blue
        
        return stackView
    }
    
    
    //logout view
    
    
    
}





// setting close button
extension SettingViewController {
    func setupCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeSettings))
    }
    
    @objc func closeSettings() {
        dismiss(animated: true, completion: nil)
    }
}




//====================================================================================================================
#if DEBUG

import SwiftUI


struct SettingVCPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewCOntroller: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SettingViewController()
    }
    
}

struct SettingVCPresentablePreviews: PreviewProvider {
    static var previews: some View {
        SettingVCPresentable()
//            .ignoresSafeArea()
    }
}



#endif
