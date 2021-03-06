//
//  Location.swift
//  MapKit-Practice
//
//  Created by Juan Ceballos on 3/23/22.
//

import Foundation
import CoreLocation

struct Location {
    let title: String
    let body: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String
    
    static func getLocations() -> [Location] {
        return [
            Location(title: "Nana", body: "Location of Nana in your area", coordinate: CLLocationCoordinate2D(latitude: 40.7594, longitude: -73.9847), imageName: "nana"),
            Location(title: "Vlada", body: "Location of Vlada in your area", coordinate: CLLocationCoordinate2D(latitude: 40.7595, longitude: -73.9847), imageName: "vlada")
        ]
    }
}

