//
//  SearchView.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
class SearchView: UIView {
    
        lazy var searchBar: UISearchBar = {
            let sb = UISearchBar()
            sb.placeholder = "Queens NY"
            sb.barTintColor = .white
            return sb
        }()
        

    lazy var mapView: MKMapView = {
       let map = MKMapView()
        map.showsUserLocation = true // default is false
        return map
    }()
        lazy var userTrackingButton: MKUserTrackingButton = {
            let button = MKUserTrackingButton()
            return button
        }()
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        
        private func commonInit() {
            setupViews()
            
        }
    private func setupViews() {
        addSubview(searchBar)
        addSubview(mapView)
        
    }
    
        
    }
 


