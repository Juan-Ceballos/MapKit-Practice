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
    let mainView = MainMapView()
    
    override func loadView() {
        view = mainView
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        convertCoordinateToPlacemark()
        convertPlacenameToCoordinate()
        mainView.mKMapView.showsUserLocation = true
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

