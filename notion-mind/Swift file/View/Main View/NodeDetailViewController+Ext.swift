//
//  NodeDetailViewController+Ext.swift
//  notion-mind
//
//  Created by 차상진 on 3/15/25.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import RxCocoa
import UIViewSeparator



//MARK: - set component
extension NodeDetailViewController {
    
    
    func setScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
        
        return scrollView
    }
    
    func setContentView() -> UIView {
        let contentView  = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
        return contentView
    }
    
    func setCoverView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
        
        guard let node = node else { return imageView }
        if node.cover != nil {
            URLSession.shared.dataTask(with: URL(string: node.cover ?? "https://picsum.photos/400/600")!) { [weak self] data, response, error in
                guard let self,
                      let data = data,
                      response != nil,
                      error == nil else { return }
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data) ?? UIImage()
                }
            }.resume()
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        
        return imageView
    }
    
    
    func setPropertyView() -> UIStackView {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor.init(hexCode: "DFDFDF")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
      
        guard let node = node else {
            print("node property 할당 안됨")
            return stackView
        }
        let props = node.property
        for prop in props {
            
            let hstack = UIStackView()
            hstack.axis = .horizontal
            hstack.alignment = .top
            hstack.distribution = .fill
            hstack.spacing = 10
            
            let propName = UILabel()
            propName.setFont(text: prop.name, size: 18, color: UIColor.init(hexCode: "787773"))
            let propValue = nodeDetailViewModel.propToView(prop: prop)
            
            hstack.addArrangedSubview(propName)
            hstack.addArrangedSubview(propValue)
            hstack.snp.makeConstraints {
                $0.height.greaterThanOrEqualTo(45)
            }
            propValue.snp.makeConstraints {
                $0.width.equalTo(propName.snp.width).multipliedBy(2.2)
            }
            
            stackView.addArrangedSubview(hstack)
        }
        
        stackView.separator(color: UIColor(hexCode: "787773") , height: 2, spacing: 12)
        
        return stackView
    }
    
    
    
}



//MARK: - set ui
extension NodeDetailViewController {
    
    
    func newSetUI() {
        view.backgroundColor = UIColor.init(hexCode: "DFDFDF")
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.snp.edges)
        }
        
        if node?.cover != nil {
            view.addSubview(imageView)
            
            headerHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: headerHeight)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: view.topAnchor), // 상단 고정
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                headerHeightConstraint
            ])
            
        }
        
       
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: node?.cover != nil ? headerHeight - 60 : 30),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        
        contentView.addSubview(propertyView)
        
        propertyView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(node?.cover != nil ? 100 : 20)
            $0.leading.equalTo(contentView.snp.leading).inset(20)
            $0.trailing.equalTo(contentView.snp.trailing).inset(20)
            $0.bottom.equalTo(contentView.snp.bottom).inset(20)
        }
        
    }
    
}




extension NodeDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if node?.cover != nil {
            
            let offsetY = scrollView.contentOffset.y
            if offsetY != 0 {
                headerHeightConstraint.constant = 0 >  (headerHeight - offsetY) ? 0 : (headerHeight - offsetY)
                // 이미지 뷰의 상단은 계속 화면 상단에 고정됨
            } else {
                // 원래 상태로 복원
                headerHeightConstraint.constant = headerHeight
            }
        }
        
    }
}





// 닫기 버튼 세팅
extension NodeDetailViewController {
    func setupCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeSettings))
    }
    
    @objc func closeSettings() {
        dismiss(animated: true, completion: nil)
    }
}




#Preview {
    NodeDetailViewController()
}
