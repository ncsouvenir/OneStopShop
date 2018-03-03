//
//  UserDefaults.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
//Keeps track fo user defaults
//setting the address
struct UserKeys {
    static let currentLatitudeKey = "Current Latitude Key"
    static let currentLongitudeKey = "Current Longitude Key"
    static let currentAddressKey = "Current Address Key"
}

class UserDefaultsHelper {
    private init(){}
    static let manager = UserDefaultsHelper()
}

// MARK:- Setters
extension UserDefaultsHelper {
    public func setLatitude(latitude: Double) {
        UserDefaults.standard.set(latitude, forKey: UserKeys.currentLatitudeKey)
    }
    
    public func setLongitude(longitude: Double) {
        UserDefaults.standard.set(longitude, forKey: UserKeys.currentLongitudeKey)
    }
    
    public func setAddress(longitude: Double) {
        UserDefaults.standard.set(longitude, forKey: UserKeys.currentAddressKey)
    }
}



// MARK:- Getters
extension UserDefaultsHelper {
    public func getLatitude() -> Double {
        guard let latitude = UserDefaults.standard.object(forKey: UserKeys.currentLatitudeKey) as? Double else { print("no stored latitude"); return 0.0 }
        return latitude
    }
    
    public func getLongitude() -> Double {
        guard let longitude = UserDefaults.standard.object(forKey: UserKeys.currentLongitudeKey) as? Double else { print("no stored longitude"); return 0.0 }
        return longitude
    }
    
    public func getAddress() -> String {
        guard let address = UserDefaults.standard.object(forKey: UserKeys.currentAddressKey) as? String else { print("no stored address"); return "Queens, NY" }
        return address
    }
}
