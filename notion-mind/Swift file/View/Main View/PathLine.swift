//
//  PathLine.swift
//  notion-mind
//
//  Created by 차상진 on 3/11/25.
//

import Foundation
import UIKit

class LineView: UIView {
    var startPoint: CGPoint = .zero
    var endPoint: CGPoint = CGPoint(x: 5, y: 5) // 기본 값 (대각선)

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setLineWidth(2.0) // 선 두께 설정
        context.setStrokeColor(UIColor.red.cgColor) // 선 색상 설정

        context.move(to: startPoint) // 시작점
        context.addLine(to: endPoint) // 끝점
        context.strokePath() // 그리기 실행
    }
}
