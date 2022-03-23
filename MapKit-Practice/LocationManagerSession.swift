//
//  LocationManagerSession.swift
//  MapKit-Practice
//
//  Created by Juan Ceballos on 3/18/22.
//

import Foundation
import CoreLocation

class LocationManagerSession: NSObject {
    let locationSession: CLLocationManager
    
    override init() {
        locationSession = CLLocationManager()
        super.init()
        locationSession.delegate = self
        locationSession.requestAlwaysAuthorization()
        locationSession.requestWhenInUseAuthorization()
        locationSession.startUpdatingLocation()
    }
    
    public func convertCoordToPM(coordinate: CLLocationCoordinate2D) {
        let clLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(clLocation) { (placemarks, error) in
            if let error = error {
                print("reverseGeocodeLocation error: \(error)")
            }
            if let firstPlacemark = placemarks?.first {
                print("placemark info: \(firstPlacemark)")
            }
        }
    }
    
    public func convertPlaceNameToCoord(addressString: String) {
        CLGeocoder().geocodeAddressString(addressString) { (placemarks, error) in
            if let error = error {
                print("geocodeAddressString error: \(error)")
            }
            if let firstPlacemark = placemarks?.first, let location = firstPlacemark.location {
                print("place name coordinate is: \(location.coordinate)")
            }
        }
    }
}

extension LocationManagerSession: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did update locations")
        print(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("when in use")
        case .denied:
            print("denied")
        case .restricted:
            print("restricted")
        case .notDetermined:
            print("nd")
        default:
            break
        }
    }
}
