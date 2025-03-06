//
//  ViewController.swift
//  notion-mind
//
//  Created by 차상진 on 3/5/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var button = CustomBorderButton()
    lazy var mainTitle = setTitle()
    lazy var imageView  = setImageView()
    lazy var stackView = setStackView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.addSubview(stackView)
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -250)
            
        ])
        
    }


}

extension ViewController {
    

    func setUI() {
        self.view.backgroundColor = UIColor.init(hexCode: "#191919")
    }
}


//MARK: - 컴포넌트
extension ViewController {
    
    func setTitle() -> UILabel {
        let label = UILabel()
        label.text = "Notion Mind"
        label.font = UIFont(name: "InriaSans-Bold", size: 40)
        return label
    }
    
    func setImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "notionMindIcon")!.resized(to: CGSize(width: 100, height: 100)))
         imageView.contentMode = .scaleAspectFit
         return imageView
    }
    
    func setStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageView, mainTitle])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.arrangedSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
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
