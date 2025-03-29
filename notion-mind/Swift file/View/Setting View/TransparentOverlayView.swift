//
//  TransparentOverlayView.swift
//  notion-mind
//
//  Created by 차상진 on 3/13/25.
//

import Foundation
import UIKit



/// 메인화면에서 설정 버튼을 클릭하면 설정 화면으로 이동하고 그 외의 이벤트는 스크롤뷰(메인화면)로 전달된다.
class TransparentOverlayView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        _ = super.hitTest(point, with: event)
        
        // 모든 버튼에 대해 터치 이벤트 허용
        if let button = subviews.first(where: { $0 is UIButton && $0.frame.contains(point) }) {
            return button
        }
        
        // 그 외에는 nil을 반환하여 터치 이벤트를 ScrollView로 전달
        return nil
    }

    
}

