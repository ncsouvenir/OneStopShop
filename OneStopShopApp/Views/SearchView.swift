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
    
    //    lazy var venueSearchBar: UISearchBar = {
    //        let searchBar = UISearchBar()
    //        searchBar.placeholder = "Search a Venue"
    //        return searchBar
    //    }()
    
    let boroughArray: [String] = ["Brooklyn", "Queens", "Bronx", "Manhattan", "Staten Island"]
    
    //    lazy var zipCodeSearchBar: UISearchBar = {
    //        let searchBar = UISearchBar()
    //        searchBar.placeholder = "Queens NY"
    //        searchBar.barTintColor = .white
    //        return searchBar
    //    }()
    //
    
    lazy var segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: boroughArray)
        segControl.backgroundColor = UIColor.white
        return segControl
    }()
    
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("New York, New York", completionHandler: { (placemark, error) in
            if let placemark = placemark {
                let location = placemark[0].location!
                let lat = location.coordinate.latitude
                let long = location.coordinate.longitude
                map.setCenter(location.coordinate, animated: true)
                
                //numbers are in meters
                //this sets the center that is zoomed in around your location
                let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 15000, 15000)
                map.setRegion(region, animated: true)
            }
        })
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
        backgroundColor = .green
        setupViews()
    }
    
    func setupViews() {
        setupVenueSearchBar()
        //setupZipCodeSearchBar()
        setupSegmentedControl()
        setupMapView()
        
    }
    
    
    func setupVenueSearchBar() {
        //search bar constraints
    }

    func setupSegmentedControl() {
        
        addSubview(segmentedControl)
        self.segmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            //make.bottom.equalTo(snp.bottom)
            make.height.equalTo(40)
        }
    }
    
    func setupMapView() {
        addSubview(mapView)
        self.mapView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom).offset(2)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(snp.bottom)
            
        }
    }
}

