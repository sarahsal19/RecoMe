//
//  MyCollectionViewCell.swift
//  myFirstProject
//
//  Created by Sarah S on 08/06/2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var recoImg: UIImageView!
    @IBOutlet weak var recoTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      // self.backgroundColor = UIColor.blue
        layer.cornerRadius = 15
        recoImg.layer.cornerRadius = 20
        recoImg.clipsToBounds = true
        layer.shadowOpacity = 1
        //recoImg.image. = 20
        layer.shadowOffset = CGSize(width: 1, height: 1)
        
    }
    
    public func configure(with model: Recommendation) {
        recoImg.image = model.img
        //recoImg.image = model.img
        recoTxt.text = model.ItemName
    }

}
