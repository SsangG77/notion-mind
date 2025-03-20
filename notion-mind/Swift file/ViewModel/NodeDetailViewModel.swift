//
//  NodeDetailViewModel.swift
//  notion-mind
//
//  Created by 차상진 on 3/16/25.
//

import Foundation
import UIKit

class NodeDetailViewModel {
    
    func propToView(prop: Property) -> UIView {
        
        switch prop.type {
        case "multi_select":
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.spacing = 8
            for value in prop.value {
                let label = UILabel()
                label.setFont(text: value.name, style: .bold, size: 15, color: .white)
                
                let valueContainer = UIView()
                valueContainer.layer.cornerRadius = 8
                valueContainer.snp.makeConstraints {
                    $0.height.greaterThanOrEqualTo(20)
                    $0.width.greaterThanOrEqualTo(40)
                }
                valueContainer.addSubview(label)
                label.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview().inset(5)  // 상하 패딩
                    $0.leading.trailing.equalToSuperview().inset(10)  // 좌우 패딩
                }

                valueContainer.backgroundColor = colorStringToColor(colorName: value.color)
                
                stackView.addArrangedSubview(valueContainer)
            }
            return stackView
            
        case "select", "status":
            let stackView  = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 5
            for value in prop.value {
                let label = UILabel()
                label.clipsToBounds = true
                label.layer.masksToBounds = true
                label.layer.cornerRadius = 6
                label.backgroundColor = colorStringToColor(colorName: value.color)
                label.setFont(text: value.name, size: 16, color: .white)
                stackView.addArrangedSubview(label)
            }
            return stackView
            
            
            
            
        case "checkbox":
            let label = UILabel()
            let value = prop.value[0].name
            label.text = value == "true" ? "✅" : "✖️"
            return label
            
//        case "relation":
            
            
        default:
            let stackView  = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 5
            for value in prop.value {
                let label = UILabel()
                label.setFont(text: value.name, size: 16)
                stackView.addArrangedSubview(label)
            }
            return stackView
        }
        
        
    } //propToView
    
    
    func colorStringToColor(colorName: String) -> UIColor {
        switch colorName {
        case "default": return UIColor(hexCode: "F1F1EF")
        case "gray": return UIColor(hexCode: "878682")
        case "brown": return UIColor(hexCode: "64473A")
        case "orange": return UIColor(hexCode: "D9730B")
        case "yellow": return UIColor(hexCode: "DFAB00")
        case "green": return UIColor(hexCode: "0E7B6C")
        case "blue": return UIColor(hexCode: "0C6E99")
        case "purple": return UIColor(hexCode: "693FA5")
        case "pink": return UIColor(hexCode: "AD1972")
        case "red": return UIColor(hexCode: "E03DF2")
        default:
            return .clear
        }
    }
}
