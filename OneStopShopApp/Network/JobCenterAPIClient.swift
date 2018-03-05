//
//  JobCenterAPIClient.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct JobCenterAPIClient {
    private init() {}
    static let manager = JobCenterAPIClient()
    
    func getResources(with zip: String, completionHandler: @escaping ([JobCenter]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let formattedZip = zip.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) else {
            errorHandler(AppError.badURL(str: zip))
            return
        }
        
        let fullUrlStr = "https://data.cityofnewyork.us/resource/9ri9-nbz5.json?zip_code=\(formattedZip)"
        guard let url = URL(string: fullUrlStr) else {errorHandler(AppError.badURL(str: fullUrlStr))
            return
        }
        let request = URLRequest(url: url)
        let parseDataIntoJobCenter: (Data) -> Void = {(data) in
            do {
                let results = try JSONDecoder().decode([JobCenter].self, from: data)
                completionHandler(results)
                
            }
            catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: parseDataIntoJobCenter, errorHandler: errorHandler)
        
        
    }
    
    func getResourcesByBorough(with borough: String, completionHandler: @escaping ([JobCenter]) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        guard let formattedBorough = borough.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) else {
            errorHandler(AppError.badURL(str: borough))
            return
        }
        let fullUrlStr = "https://data.cityofnewyork.us/resource/9ri9-nbz5.json?borough=\(formattedBorough)"
        guard let url = URL(string: fullUrlStr) else {errorHandler(AppError.badURL(str: fullUrlStr))
            return
        }
        let request = URLRequest(url: url)
        let parseDataIntoJobCenter: (Data) -> Void = {(data) in
            do {
                let results = try JSONDecoder().decode([JobCenter].self, from: data)
                completionHandler(results)
            }
            catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: parseDataIntoJobCenter, errorHandler: errorHandler)
        
    }
    
    
}
