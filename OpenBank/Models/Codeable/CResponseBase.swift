//
//  CResponseBase.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 2/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import UIKit

struct CCharactersResponse: Codable {
    let code: Int
    let status: String
    let data: ResponseData?
    
    
    struct ResponseData: Codable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results:[CCharacter]?
    }
}
