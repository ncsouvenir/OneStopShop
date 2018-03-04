//
//  ImageResizer.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

extension UIImage {
    
    func reDrawImage(using size: CGSize) -> UIImage{
        let customImage = self
        //creating image context:
        UIGraphicsBeginImageContext(size)
        customImage.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let reSizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return reSizedImage!
    }
    
}
