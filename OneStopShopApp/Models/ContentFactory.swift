//
//  ContentFactory.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
struct ContentComponents {
    let detail: String?
}
struct ContentFactory {
    static func getContentComponents(jobCenter: JobCenter) -> [ContentComponents] {
        var components = [ContentComponents]()
        let nameComponent = ContentComponents(detail: jobCenter.facilityName)
        let addressComponent = ContentComponents(detail: jobCenter.streetAddress)
        let phoneComponent = ContentComponents(detail: jobCenter.phoneNumber)
        let cityComponent = ContentComponents(detail: jobCenter.city)
        components.append(nameComponent)
        components.append(addressComponent)
        components.append(phoneComponent)
        components.append(cityComponent)
        return components
        
    }
}

