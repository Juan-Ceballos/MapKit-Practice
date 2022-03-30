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
    
    // isShowingAnnotations
    // annotations
    private var currImgNames = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //convertCoordinateToPlacemark()
        //convertPlacenameToCoordinate()
        mainView.mKMapView.showsUserLocation = true
        mainView.mKMapView.delegate = self
        //loadMapView()
        //mainView.mKMapView.register(<#T##viewClass: AnyClass?##AnyClass?#>, forAnnotationViewWithReuseIdentifier: <#T##String#>)
    }
    
    private func makeAnnotations(userCoord: CLLocationCoordinate2D, id: String) -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        let currentRegion = CLCircularRegion(center: userCoord, radius: 600, identifier: id)
        for location in Location.getLocations() {
            // if location within region do this, maybe get the location of all users
            // or research device tracks registered devices in area
            if currentRegion.contains(location.coordinate) {
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                annotation.title = location.title
                currImgNames[location.title] = location.imageName
                print("image name:")
                print(location.imageName)
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
    // navigate pass to detail view controller
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("did select annotations")
        let dv = DetailMapViewController()
        present(dv, animated: false)
    }
    
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        guard annotation is MKPointAnnotation else {
    //            return nil
    //        }
    //
    //        let identfier = "locationAnnotation"
    //        var annotationView: MKPinAnnotationView
    //
    //        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identfier) as? MKPinAnnotationView {
    //            annotationView = dequeueView
    //        } else {
    //            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identfier)
    //            annotationView.canShowCallout = true
    //            let currImage = currImgNames[(annotation.title ?? "none") ?? "none"] ?? "none"
    //            if currImage == "none" {
    //                annotationView.image = UIImage(systemName: "person")
    //            } else {
    //                annotationView.contentMode = .scaleAspectFit
    //                let image = UIImage(named: currImage)
    //                image
    //                annotationView.image = image
    //            }
    //        }
    //
    //        return annotationView
    //    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        let identfier = "locationAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identfier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identfier)
            annotationView?.canShowCallout = true
            
            let currImage = currImgNames[(annotation.title ?? "none") ?? "none"] ?? "none"
            print("currImage = \(currImage)")
            if currImage == "none" {
                annotationView?.glyphImage = UIImage(systemName: "person")
            } else {
                //let image = UIImage(named: currImage)
                annotationView?.glyphImage = UIImage(systemName: "person")
            }
            
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // stuff here
    }
    
    // set region for zoom in
    
    // user moving removing old annotations adding new ones? recalc annotations?
    // bug annimating?
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("did update location")
        let userCoord = mapView.userLocation.coordinate
        let currAnnotations = mapView.annotations
        mapView.removeAnnotations(currAnnotations)
        let annotations = makeAnnotations(userCoord: userCoord, id: "idLoc")
        mapView.addAnnotations(annotations)
        //mapView.showAnnotations(annotations, animated: false)
        let region = MKCoordinateRegion(center: userCoord, latitudinalMeters: 50, longitudinalMeters: 50)
        mainView.mKMapView.setRegion(region, animated: true)
    }
    
    // careful when annotations so doesnt keep zooming in might need bool var and public annotations
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        // another way of adding annotations maybe
        //let userCoord = mapView.userLocation.coordinate
        //print("this is user loc: \(userCoord)")
        //let annotations = makeAnnotations(userCoord: userCoord, id: "idLoc")
        //mapView.addAnnotations(annotations)
    }
}
