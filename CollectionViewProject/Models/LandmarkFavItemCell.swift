//
//  LandmarkFavItemCell.swift
//  CollectionViewProject
//
//  Created by lpiem on 09/03/2022.
//

import UIKit

class LandmarkFavItemCell: UICollectionViewCell{

    @IBOutlet weak var favLandmarkImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        favLandmarkImage.makeRounded()
    }
}
