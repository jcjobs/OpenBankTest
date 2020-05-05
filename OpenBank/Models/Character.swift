//
//  Character.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 3/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import UIKit

struct Character {
    let id: Int
    let name: String
    let detail: String
    let modified: String
    var dateUpdated:Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: modified)
    }
    let urlDetail: String?
    let characterImageUrl:String
}
