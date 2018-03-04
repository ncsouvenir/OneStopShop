//
//  LocationService.swift
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
    
    var searchView = SearchView()
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
        guard let userLocation: CLLocation = locations.last else { print("no location data"); return }
        print("didUpdateLocations: \(locations)")
        //print("locations = \(location.latitude) \(location.longitude)")
        //manager.stopUpdatingLocation()
        
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.2,0.2)
        let region = MKCoordinateRegion(center: coordinations, span: span)
        searchView.mapView.setRegion(region, animated: true)

        //Update User Preferences: sets users last location as the location when you open the app back up
        UserDefaultsHelper.manager.setLatitude(latitude: userLocation.coordinate.latitude)
        UserDefaultsHelper.manager.setLongitude(longitude: userLocation.coordinate.longitude)
        //locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did fail with \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization: \(status)") //ex) .denied, .notDetermined
    }
}
