//
//  DetailLandmarkViewController.swift
//  CollectionViewProject
//
//  Created by lpiem on 16/03/2022.
//

import UIKit

class DetailLandmarkViewController: UIViewController{
    var landmark: Landmark?
    
    @IBOutlet weak var imageDetailLandmark: UIImageView!
    @IBOutlet weak var parkDetailLandmark: UILabel!
    @IBOutlet weak var descDetailLandmark: UILabel!
    @IBOutlet weak var longitudeDetailLandmark: UILabel!
    @IBOutlet weak var latitudeDetailLandmark: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parkDetailLandmark.text = landmark?.park
        descDetailLandmark.text = landmark?.description
        longitudeDetailLandmark.text = landmark?.coordinates.longitude.description
        latitudeDetailLandmark.text = landmark?.coordinates.latitude.description
        imageDetailLandmark.image = landmark?.image
    }
}
