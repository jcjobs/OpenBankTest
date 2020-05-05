//
//  CCharacter.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 1/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import UIKit

struct CCharacter: Codable {
    let id: Int
    let name: String
    let detail: String
    let modified: String
    let thumbnail: Thumbnail
    let urls: [Urls]?
    enum CodingKeys: String, CodingKey {
        case id, name, modified, thumbnail, urls
        case detail = "description"
    }
    
    struct Thumbnail : Codable {
        let path: String
        let imageExtension: String
        enum CodingKeys: String, CodingKey {
            case path
            case imageExtension = "extension"
        }
    }
    
    struct Urls : Codable {
        let type: String
        let url: String
    }
    
    
}
