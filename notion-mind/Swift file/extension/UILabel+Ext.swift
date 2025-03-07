//
//  UILabel+Ext.swift
//  notion-mind
//
//  Created by 차상진 on 3/7/25.
//

import Foundation
import UIKit



extension UILabel {

    func setFont (
        text: String = "텍스트",
        style: FontStyle  = .regular,
        size: CGFloat = 11.0,
        color: UIColor = .black
    ) {
        self.text = text
        self.font = font.setFontStyle(style: style, size: size)
        self.textColor = color
    }
}
