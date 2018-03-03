//
//  UserPreference.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
struct UserKeys {
    static let currentLatitudeKey = "Current Latitude Key"
    static let currentLongitudeKey = "Current Longitude Key"
    static let currentAdrressKey = "Current Adrress Key"
}

class UserPreference {
    static let manager = UserPreference()
    private init() {}
}
extension UserPreference {
    public func setLatitude(latitude: Double) {
        UserDefaults.standard.set(latitude, forKey: UserKeys.currentLatitudeKey)
    }
    public func setLongitude(longitude: Double) {
        UserDefaults.standard.set(longitude, forKey: UserKeys.currentLongitudeKey)
    }
    public func setAdderess(address: String) {
        UserDefaults.standard.set(address, forKey: UserKeys.currentAdrressKey)
    }
}
extension UserPreference {
    func getUserLatitude() -> Double {
        guard let lat = UserDefaults.standard.object(forKey: UserKeys.currentLatitudeKey) as? Double else {
            print("no stored latitude")
            return 0.0
        }
           return lat
        }
    

    func getUserLongitude() -> Double {
        guard let long = UserDefaults.standard.object(forKey: UserKeys.currentLatitudeKey) as? Double else {
            print("no stored longitude")
            return 0.0
        }
        return long
}

}
