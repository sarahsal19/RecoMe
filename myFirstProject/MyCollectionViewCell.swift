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
        // Initialization code
    }
    
    public func configure(with model: Recommendation) {
        //recoImg.image = model.image
        recoTxt.text = model.ItemName
    }

}
