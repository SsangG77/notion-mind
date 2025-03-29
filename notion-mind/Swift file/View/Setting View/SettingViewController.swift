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
        
        
        settingViewModel.fetchDatabaseList()
        
        settingViewModel.databases
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { vc, databases in
                // 기존의 모든 arrangedSubview 제거
                vc.stackDBView.arrangedSubviews.forEach { $0.removeFromSuperview() }

                // 새로운 데이터베이스 목록 추가
                databases.forEach { database in
                    
                    UIView.transition(
                        with: vc.stackDBView,
                        duration: 0.3,
                        options: .transitionCrossDissolve,
                        animations: {
                            vc.stackDBView.addArrangedSubview(self.setSingleDBView(database: database))
                    })
                    
                }
            })
            .disposed(by: disposeBag)
        
        logoutButton.rx.tap
            .bind {
                self.settingViewModel.logoutButtonTapped.accept($0)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let contentView = scrollView.subviews.first {
            scrollView.contentSize = contentView.frame.size
        }
    }
}

//MARK: - set Layout
extension SettingViewController {
    
    func setUI() {
        view.backgroundColor = UIColor(hexCode: "DFDFDF")
        
        view.addSubview(selectedDBTitle)
        selectedDBTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(100)
        }
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(50)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(selectedDBTitle.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(logoutButton.snp.top).inset(-10)
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }

        contentView.addSubview(stackDBView)
        stackDBView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
}


// components
extension SettingViewController {
    
    
    //scrollview
    func setScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
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
        label.changeTextColorByBG(for: color)
        
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
