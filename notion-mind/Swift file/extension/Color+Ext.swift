//
//  Color+Ext.swift
//  notion-mind
//
//  Created by 차상진 on 3/5/25.
//

import Foundation
import UIKit

extension UIColor {
    
    
    // hexcode로 색 추출
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    
    
    
    static let adaptiveBackground: UIColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(hexCode: "#262626") : UIColor(hexCode: "#F1F1F1")
        }
    
    static let adaptiveForeground: UIColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(hexCode: "#F1F1F1") : UIColor(hexCode: "#262626")
        }
}
