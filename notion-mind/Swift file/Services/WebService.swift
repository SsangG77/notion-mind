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
    var database = ""
    
    
    init() {
        auth      = self.setServerIP(.local) + "/auth/notion"
        nodeData  = self.setServerIP(.local) + "/data/nodes"
        database  = self.setServerIP(.local) + "/data/database"
    }
    
    
    
    func setServerIP(_ host: HostType) -> String {
        switch host {
        case .local:
            return "https://8b62-58-226-117-28.ngrok-free.app"
            
            
        case .global:
            
            #warning("서버 호스팅 후 ip 추가")
            return ""
        }
    }
    
}



