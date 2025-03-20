//
//  Service.swift
//  notion-mind
//
//  Created by 차상진 on 3/9/25.
//

import Foundation




struct Service {
    
    static func myPrint<T>(_ title: String, _ content: T = (Any).self, completion:() -> Void = {}) {
        print("")
        print("================================================== \(title) ==================================================")
        completion()
        print(content)
    }
    
}
