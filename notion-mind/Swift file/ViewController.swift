//
//  ViewController.swift
//  notion-mind
//
//  Created by 차상진 on 3/5/25.
//

import UIKit

class ViewController: UIViewController {
    
    let connectNotionBtn = ConnectNotionButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .red
        
        self.view.addSubview(connectNotionBtn)
        connectNotionBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            connectNotionBtn.heightAnchor.constraint(equalToConstant: 60),
            connectNotionBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -350),
            connectNotionBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70),
            connectNotionBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            connectNotionBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        
    }


}


#if DEBUG

import SwiftUI


struct MainVCPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewCOntroller: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ViewController()
    }
    
}

struct MainVCPresentablePreviews: PreviewProvider {
    static var previews: some View {
        MainVCPresentable()
            .ignoresSafeArea()
    }
}



#endif
