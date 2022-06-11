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
        
       self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 15
        recoImg.layer.cornerRadius = 20
        recoImg.clipsToBounds = true
        self.layer.shadowOpacity = 1
        //recoImg.image. = 20
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        recoTxt.padding = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 3)

        
    }
    
    public func configure(with model: Recommendation) {
       // recoImg.loadImageUsingCacheWithUrlString(model.img)
        //recoImg.image = model.img
        recoTxt.text = model.RecoText
    }

}
