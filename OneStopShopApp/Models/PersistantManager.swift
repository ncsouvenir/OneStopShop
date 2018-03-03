//
//  PersistantManager.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
class PersistantManager {
private init() {}
static var manager = PersistantManager()
let kPath = "favorites.plist"

private var favorites = [JobCenter]() {
    didSet {
        saveFavorites()
    }
}

func getDocumentDirectory() -> URL {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[0]
}
func dataFilePath(of pathName: String) -> URL {
    return getDocumentDirectory().appendingPathComponent(pathName)
}


func saveFavorites() {
    let urlPath = dataFilePath(of: kPath)
    do {
        let data = try PropertyListEncoder().encode(favorites)
        try data.write(to: urlPath)
        
        print("===========collections==================\n")
        print(urlPath)
        print("=======================================")
    } catch {
        print("encoding collections error: \(error)")
    }
}


func loadFavorites() {
    let urlPath = dataFilePath(of: kPath)
    do {
        let data = try Data(contentsOf: urlPath)
        favorites = try PropertyListDecoder().decode([JobCenter].self, from: data)
    } catch {
        print("Decoding collections error: \(error)")
    }
}


// load image
    func getImage(jobCenter: JobCenter) -> UIImage? {
    let imageUrl = dataFilePath(of: jobCenter.nta)
    do {
        let data =  try Data(contentsOf: imageUrl)
        let image = UIImage(data: data)
        return image
    } catch {
        print("loading image error: \(error)")
    }
    return nil
}
// get venues
func getFavotites() -> [JobCenter]{
    return favorites
}
// add venues, save image to file
func addFavorite(newJob: JobCenter) {
    // check venue already saved or not
    let index = favorites.index(where: {newJob.nta == $0.nta})
    if index != nil { return }
    
    self.favorites.append(newJob)
    
//    let imageUrl = dataFilePath(of: newJob.nta)
//    if let imageData = UIImagePNGRepresentation(newImage) {
//        do {
//            try imageData.write(to: imageUrl)
//        } catch {
//            print("Saving image error: \(error)")
//        }
//    }
    
}

}
