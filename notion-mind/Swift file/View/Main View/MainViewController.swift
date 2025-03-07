//
//  MainViewController.swift
//  notion-mind
//
//  Created by 차상진 on 3/7/25.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxRelay

class MainViewController: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return scrollView
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.backgroundColor = .red
        
        //페이지들이 불러와져야 함.
        //그 페이지들을 겹치지 않게 배치
        //관계되어 있는 페이지끼리 선 연결 - 노드 뒤에 위치하기
        //노드를 길게 누르면 이동되게 하기
        
        
        
        
        
        
        
       
        
        
    }

}







//MARK: - node model
#warning("따로 모델 파일 만들어서 옮기기")
struct Node {
    let id: String
    let icon: String?
    let cover: String?
    let title: String?
    let property: [Property<Any>]
    
}


//MARK: - 속성 model
#warning("따로 모델 파일 만들어서 옮기기")
struct Property<T> {
    let name: String
    let value: T
}
