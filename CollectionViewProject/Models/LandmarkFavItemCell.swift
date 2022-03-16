//
//  LandmarkFavItemCell.swift
//  CollectionViewProject
//
//  Created by lpiem on 09/03/2022.
//

import UIKit

class LandmarkFavItemCell: UICollectionViewCell{

    @IBOutlet weak var favLandmarkImage: UIImageView!
    
    func configure(landmark: Landmark){
        favLandmarkImage.image = landmark.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        favLandmarkImage.makeRounded()
    }
}

extension UIImageView {
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor(named: "favBorder")?.cgColor
        self.layer.cornerRadius = 50
        self.clipsToBounds = true
    }
}
