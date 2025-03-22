//
//  WebService.swift
//  notion-mind
//
//  Created by 차상진 on 3/20/25.
//

import Foundation


class WebService {
    
    enum HostType {
        case local, global
    }
    
    var auth = "" // notion auth url
    var nodeData = "" // 인증된 페이지, 데이터베이스들의 모든 하위 페이지
    
    
    
    init() {
        auth = self.setServerIP(.local) + "/auth/notion"
        nodeData = self.setServerIP(.local) + "/data/nodes"
    }
    
    
    
    func setServerIP(_ host: HostType) -> String {
        switch host {
        case .local:
            return "https://1bf9-58-226-117-28.ngrok-free.app" //localhost ngrok
            
        case .global:
            
            return "" // TODO: 서버 호스팅 후 ip 추가
        }
    }
    
}



