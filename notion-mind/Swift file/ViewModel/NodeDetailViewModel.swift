//
//  NodeDetailViewModel.swift
//  notion-mind
//
//  Created by 차상진 on 3/16/25.
//

import Foundation

class NodeDetailViewModel {
    func propToString(prop: Property<Any>) -> String {
        
        var result = ""
        
        switch prop.type {
        case .multi_select:
            let propValueArray = prop.value as! [String]
            for singleValue in propValueArray {
                if singleValue == propValueArray.last {
                    result += singleValue
                } else {
                    result += singleValue + "\n"
                }
            }
            
            break
            
        case .relation:
            let propValueArray = prop.value as! [String]
            let matched = MainViewModel.shared.nodesRelay.value.filter({ node in propValueArray.contains(node.id) })
            
            for singleValue in matched {
                guard let val = singleValue.title else { continue }
                result += val + "\n"
            }
            
            break
            
        case .checkbox:
            let propValue = prop.value as! Bool
            result += propValue == true ? "✅" : "✖️"
            
            break
        
        default:
            result += prop.value as! String
            
            break
        }//switch
        
        return result
        
    }
}
