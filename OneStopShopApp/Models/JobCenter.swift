//
//  JobCenter.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import CoreLocation

struct JobCenter: Codable {
    let borough: String
    let streetAddress: String
    let comments: String?
    let facilityName: String?
    let city: String
    let latitude: String?
    let longitude: String?
    let zipCode: String
    let phoneNumber: String
    enum CodingKeys: String, CodingKey {
        case borough
        case streetAddress = "street_address"
        case comments
        case facilityName = "facility_name"
        case city
        case latitude
        case longitude
        case zipCode = "zip_code"
        case phoneNumber = "phone_number_s"
    }
    
    var coordinate: CLLocationCoordinate2D {
        guard let lat = latitude, let long = longitude else {return CLLocationCoordinate2DMake(0.0, 0.0)}
        guard let latDouble = Double(lat), let longDouble = Double(long) else {return CLLocationCoordinate2DMake(0.0, 0.0)}
        return CLLocationCoordinate2DMake(latDouble, longDouble)
        
    }
    var primaryPhoneNumber: String {
        let phoneArr = phoneNumber.components(separatedBy: "/")
        guard let phoneNumber = phoneArr.first else {return "N/A"}
        return phoneNumber
        
    }
    
    
}
