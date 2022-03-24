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
        //convertCoordinateToPlacemark()
        //convertPlacenameToCoordinate()
        mainView.mKMapView.showsUserLocation = true
        loadMapView()
    }
    
    private func makeAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        for location in Location.getLocations() {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = location.title
            annotations.append(annotation)
        }
        
        return annotations
    }
    
    private func loadMapView() {
        let annotations = makeAnnotations()
        mainView.mKMapView.addAnnotations(annotations)
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

