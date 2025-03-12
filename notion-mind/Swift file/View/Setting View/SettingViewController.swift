//
//  SettingViewController.swift
//  notion-mind
//
//  Created by 차상진 on 3/12/25.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "설정"
        
        setupCloseButton()
    }
    
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
            .ignoresSafeArea()
    }
}



#endif
