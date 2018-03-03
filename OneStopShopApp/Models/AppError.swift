//
//  AppError.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
enum AppError: Error {
    case badData
    case badURL(str: String)
    case codingError(rawError: Error)
    case badStatusCode(num: Int)
    case other(rawError: Error)
}
