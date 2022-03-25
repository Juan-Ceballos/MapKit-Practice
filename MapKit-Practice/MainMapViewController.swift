//
//  ViewController.swift
//  MapKit-Practice
//
//  Created by Juan Ceballos on 3/18/22.
//

import UIKit
import MapKit

class MainMapViewController: UIViewController {
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
        mainView.mKMapView.delegate = self
        //loadMapView()
    }
    
    private func makeAnnotations(userCoord: CLLocationCoordinate2D, id: String) -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        let currentRegion = CLCircularRegion(center: userCoord, radius: 400, identifier: id)
        for location in Location.getLocations() {
            // if location within region do this, maybe get the location of all users
            // or research device tracks registered devices in area
            if currentRegion.contains(location.coordinate) {
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                annotation.title = location.title
                annotations.append(annotation)
            }
        }
        
        return annotations
    }
    
//    private func loadMapView() {
//        let annotations = makeAnnotations()
//        print("user coord from load map")
//        print(mainView.mKMapView.userLocation.coordinate)
//        // since region is set will only see nearby annotations unless zoomout
//        mainView.mKMapView.addAnnotations(annotations)
//        //mainView.mKMapView.showAnnotations(annotations, animated: false)
//        //mainView.mKMapView.annotations(in: _)
//    }

    public func convertCoordinateToPlacemark() {
        if let location = Location.getLocations().first {
            locationSession.convertCoordToPM(coordinate: location.coordinate)
        }
    }
    
    public func convertPlacenameToCoordinate() {
        locationSession.convertPlaceNameToCoord(addressString: "miami")
    }
}

extension MainMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("did select annotations")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        let identfier = "locationAnnotation"
        var annotationView: MKPinAnnotationView
        
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identfier) as? MKPinAnnotationView {
            annotationView = dequeueView
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identfier)
            annotationView.canShowCallout = true
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // stuff here
    }
    
    // set region for zoom in
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let userCoord = mapView.userLocation.coordinate
        print("this is user loc: \(userCoord)")
        let annotations = makeAnnotations(userCoord: userCoord, id: "idLoc")
        mapView.addAnnotations(annotations)
        //mapView.showAnnotations(annotations, animated: false)
        let region = MKCoordinateRegion(center: userCoord, latitudinalMeters: 400, longitudinalMeters: 400)
        mainView.mKMapView.setRegion(region, animated: true)
    }
    
}
