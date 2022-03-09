//
//  Coordinates.swift
//  CollectionViewProject
//
//  Created by lpiem on 09/03/2022.
//

import CoreLocation

struct Coordinates: Decodable, Hashable {
    var longitude: CLLocationDegrees
    var latitude: CLLocationDegrees
}
