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
        
        // settingButton이 터치되면 해당 버튼을 리턴하여 터치 이벤트 허용
        if let button = subviews.first(where: { $0 is UIButton }),
           button.frame.contains(point) {
            return button
        }
      
        
        // 그 외에는 nil을 반환하여 터치 이벤트를 ScrollView로 전달
        return nil
    }
}

