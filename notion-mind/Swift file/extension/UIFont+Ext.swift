//
//  UIFont.swift
//  notion-mind
//
//  Created by 차상진 on 3/7/25.
//

import Foundation
import UIKit



enum FontStyle {
    case regular, bold
}


extension UIFont {
    func setFontStyle(style: FontStyle, size: CGFloat) -> UIFont {
           var font = ""
           
           switch style {
           case .regular:
               font = "InriaSans-Regular"
           case .bold:
               font = "InriaSans-Bold"
           }
           
           return UIFont(name: font, size: size) ?? UIFont.systemFont(ofSize: size)
       }
}
