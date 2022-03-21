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
    }
}

extension LocationManagerSession: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did update locations")
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
