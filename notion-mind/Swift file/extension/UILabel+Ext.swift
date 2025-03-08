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
    
    
    func changeTextColorByBG(for bgColor: UIColor) {
        var white: CGFloat = 0
        bgColor.getWhite(&white, alpha: nil)
    
        
        self.textColor = white > 0.5 ? .black : .white
    }
    
    
    
}
