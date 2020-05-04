//
//  CEmptyRequest.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 1/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import UIKit

class CBaseRequest: Codable {
    
    let apikey = SecretKey.publicApiKey.rawValue
    let ts: Int64
    let hash: String
    let limit: Int
    let offset: Int
    init(offset:Int = 0, limit:Int = 1) {
        let timestamp = Date().timeIntervalSince1970
        let tsValue = Int64(timestamp * 1000)
        self.ts = tsValue
        
        let keyMD5Value = SecurityHanlder.MD5(string: "\(tsValue)" + SecretKey.privateApiKey.rawValue  + self.apikey)
        let hashValue = keyMD5Value.hexEncodedString()
        self.hash = hashValue
        
        self.limit = limit
        self.offset = offset
    }
    
}
