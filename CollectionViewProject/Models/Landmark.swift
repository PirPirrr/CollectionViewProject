//
//  Landmark.swift
//  CollectionViewProject
//
//  Created by lpiem on 09/03/2022.
//

import Foundation
import UIKit
import CoreLocation

struct Landmark: Decodable, Hashable{
    enum Category: String, CaseIterable, Decodable{
        case lakes = "Lakes"
        case moutains = "Mountains"
        case rivers = "Rivers"
    }
    
    
    var name: String
    var category: String
    var city: String
    var state: String
    var id : Int
    var isFeatured: Bool
    var isFavorite: Bool
    var park: String
    var coordinates: Coordinates
    var description: String
    private var imageName: String
    
    var image: UIImage{
        return UIImage(named: imageName)!
    }
    
    var lcoationCoordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}
