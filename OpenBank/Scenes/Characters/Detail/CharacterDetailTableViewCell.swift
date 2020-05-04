//
//  CharacterDetailTableViewCell.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 3/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import UIKit

class CharacterDetailTableViewCell: UITableViewCell {
    
    static let identifier = "CharacterDetailTableViewCellId"
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txvDetail: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with title: String, detail: String) {
        lblTitle.text = title
        txvDetail.text = detail
    }

}
