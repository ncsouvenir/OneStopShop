//
//  LocationServices.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import  MapKit
// CLLocation has points: lat and long

class LocationService: NSObject {
    //BP: Apple highly recommends having one instance of the location manager
    private override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    static let manager = LocationService()
   
    
    private var locationManager: CLLocationManager!
}

//MARK: - Helper Function
extension LocationService {
    //Checking to see if user has or has not authorized location services
    public func checkForLocationServices() -> CLAuthorizationStatus {
        var status: CLAuthorizationStatus!
        
        //check if location services are enabled
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus(){
            case .notDetermined: //initial state on first launch
                print("not detirmined")
                locationManager.requestWhenInUseAuthorization()
            case .denied: //user could potentially deny access
                print("denied")
            case .authorizedAlways:
                print("authorized always")
            case .authorizedWhenInUse:
                print("authorizedWhenInUse")
            default:
                break
            }
        }
        else {
            //TODO: - update UI accordingly
            status = CLLocationManager.authorizationStatus()
        }
        status = CLLocationManager.authorizationStatus()
        return status
    }
}

//MARK: - CLLoation Manager Delegate
extension LocationService: CLLocationManagerDelegate {
    
    //called every time user updates location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did update with CLLocation \(locations)")
        
//        let location = CLLocationCoordinate2D(latitude: 35.689949, longitude: 139.697576)
//        let center = location
//        let region = MKCoordinateRegionMake(center, MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
//        pokemonMap.setRegion(region, animated: true)
        
        guard let location = locations.last else {print("no location data");return}
        
        //Update User Preferences: sets users last location as the location when you open the app back up
        UserDefaultsHelper.manager.setLatitude(latitude: location.coordinate.latitude)
        UserDefaultsHelper.manager.setLongitude(longitude: location.coordinate.longitude)
        //locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did fail with \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization: \(status)") //ex) .denied, .notDetermined
    }
}




