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
 



class SearchView: UIView {
    
    lazy var zipCodeSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Queens NY"
        searchBar.barTintColor = .white
        return searchBar
    }()
    
//    lazy var segmentedControl: UISegmentedControl = {
//        let segControl = UISegmentedControl()
//        segControl.setTitle("Brooklyn", forSegmentAt: 0)
//        segControl.setTitle("Queens", forSegmentAt: 1)
//        segControl.setTitle("Manhattan", forSegmentAt: 2)
//        segControl.setTitle("Bronx", forSegmentAt: 3)
//        segControl.setTitle("Staten Island", forSegmentAt: 4)
//        return segControl
//    }()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .purple
        setupViews()
    }
    
    func setupViews() {
        setupVenueSearchBar()
        setupZipCodeSearchBar()
        setupMapView()
       // setupSegmentedControl()
    }
    
    
    func setupVenueSearchBar() {
       //search bar constraints
    }

    
    func setupZipCodeSearchBar() {
        addSubview(zipCodeSearchBar)
        self.zipCodeSearchBar.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(40)
            
        }
    }
    
//    func setupSegmentedControl() {
//        addSubview(segmentedControl)
//        self.segmentedControl.snp.makeConstraints { (make) in
//            make.top.equalTo(zipCodeSearchBar.snp.bottom)
//            make.leading.equalTo(snp.leading)
//            make.trailing.equalTo(snp.trailing)
//            //make.bottom.equalTo(snp.bottom)
//            make.height.equalTo(50)
//
//
//        }
//    }
    
    
    
    func setupMapView() {
        addSubview(mapView)
        self.mapView.snp.makeConstraints { (make) in
            make.top.equalTo(zipCodeSearchBar.snp.bottom)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(snp.bottom)
            
        }
    }
    

}

