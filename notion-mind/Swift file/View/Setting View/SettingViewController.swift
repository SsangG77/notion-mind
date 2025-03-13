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


class SettingViewController: UIViewController {
    
    // view model
    let loginViewModel = LoginViewModel()
    
    // 컴포넌트
    lazy var scrollView = setScrollView()
    lazy var selectedDBTitle = setSelectedDatabaseTitle()
    lazy var logoutButton = CustomBorderButton(frame: .zero, type: .logout)
    lazy var stackDBView = setDBListView()
    
    // rx
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexCode: "DFDFDF")
        title = "Setting"
        setupCloseButton() // setting close button
        setUI()
        
     
        
    }
    

    
    
}


extension SettingViewController {
    
    func setUI() {
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

        scrollView.addSubview(logoutButton)
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(stackDBView.snp.bottom).offset(330)
//            $0.bottom.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50) // 마지막 뷰의 하단을 scrollView의 bottom과 연결
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
    func setSingleDBView(title: String) -> UIView {
        let dbView = UIView()
        dbView.backgroundColor = UIColor(hexCode: "D0D0D0")
        dbView.layer.cornerRadius = 12
        dbView.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        let label = UILabel()
        label.setFont(text: title, size: 20)
        
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
        
#warning("임시 데이터베이스 데이터")
        stackView.addArrangedSubview(setSingleDBView(title: "A DB"))
        stackView.addArrangedSubview(setSingleDBView(title: "A DB"))
        stackView.addArrangedSubview(setSingleDBView(title: "A DB"))
        
        
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
