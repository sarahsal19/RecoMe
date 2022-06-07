//
//  CollectionViewCell.swift
//  myFirstProject
//
//  Created by Sarah S on 06/06/2022.
//

//
//  CollectionViewCell.swift
//  PinterestLayout
//
//  Created by Khrystyna Shevchuk on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import PinterestLayout


class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var image: UIImage? {
        didSet {
            if let image = image {
                imageView.image = image
            } else {
                imageView.backgroundColor = .lightGray
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            //change image view height by changing its constraint
            imageViewHeightLayoutConstraint.constant = attributes.imageHeight
        }
    }
}
