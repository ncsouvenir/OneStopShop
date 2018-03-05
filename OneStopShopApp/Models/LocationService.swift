//
//  LocationService.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//


import Foundation
import CoreLocation

////class LocationService: NSObject {
////    // singleton manager
////    //NB: Apple highly recommends having one instance of the location manager
////    private override init() {
////        super.init()
////        locationManager = CLLocationManager()
////        locationManager.delegate = self
////        locationManager.startUpdatingLocation()
////        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
////        
////        
////    }
////    static let manager = LocationService()
////    private var locationManager: CLLocationManager!
////    
////}
class LocationService {
    static let manager = LocationService()
    private var locationManager: CLLocationManager!
    private init() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
    }
}
extension LocationService: CLLocationManagerDelegate {
    
}



//extension LocationService {
//    public func checkForLocationServices() {
//        var status: CLAuthorizationStatus!
//
//        //check if location service is enabled
//        if CLLocationManager.locationServicesEnabled() {
//            switch CLLocationManager.authorizationStatus() {
//            case .authorizedAlways, .authorizedWhenInUse:
//                print("Authorized")
//            case .denied, .restricted:
//                print("Denied")
//            case .notDetermined:
//                locationManager.requestWhenInUseAuthorization()
//            }
//            status = CLLocationManager.authorizationStatus()
//        } else {
//            //TODO:
//        }
//    }
//}
//extension LocationService: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("didUpdateLocations: \(locations)")
//        guard let location = locations.last else {print("no location data")
//            return
//        }
//        UserPreference.manager.setLatitude(latitude: location.coordinate.latitude)
//        UserPreference.manager.setLongitude(longitude: location.coordinate.longitude)
//
//        locationManager.stopUpdatingLocation()
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("didFailWithError: \(error.localizedDescription)")
//    }
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print("didChangeAuthorization: \(status)") //e.g. .denied
//    }
//
//}

