//
//  ViewController.swift
//  MapKit-Practice
//
//  Created by Juan Ceballos on 3/18/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    private let locationSession = LocationManagerSession()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        convertCoordinateToPlacemark()
        convertPlacenameToCoordinate()
    }

    public func convertCoordinateToPlacemark() {
        if let location = Location.getLocations().first {
            locationSession.convertCoordToPM(coordinate: location.coordinate)
        }
    }
    
    public func convertPlacenameToCoordinate() {
        locationSession.convertPlaceNameToCoord(addressString: "miami")
    }
}

