//
//  CharactersCollectionViewCell.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 2/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CharactersCollectionViewCellId"
    
    @IBOutlet weak var lblCharacterName: UILabel!
    @IBOutlet weak var imvCharacter: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imvCharacter.image = nil
    }
       
    func configure(with name: String, urlString: String) {
        lblCharacterName.text = name
        imvCharacter.fromRemotePath(urlPath: urlString)
        
           
        lblCharacterName.sizeToFit()
        setStyle()
    }
       
    private func setStyle() {
       self.layer.cornerRadius = 10
       
       self.contentView.layer.cornerRadius = 10.0
       self.contentView.layer.borderWidth = 0.5
       self.contentView.layer.borderColor = UIColor.clear.cgColor
       self.contentView.layer.masksToBounds = true

       self.layer.shadowColor = UIColor.gray.cgColor
       self.layer.shadowOffset = CGSize(width: 0, height: 8.0)
       self.layer.shadowRadius = 5.0
       self.layer.shadowOpacity = 0.5
       self.layer.masksToBounds = false
       self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
