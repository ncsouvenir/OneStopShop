//
//  SearchViewController.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

import CoreLocation
import MapKit

class SearchViewController: UIViewController {
    
    let searchView = SearchView()
    var currentSelectedJobCenter: JobCenter!
    private var annotations = [MKAnnotation]()
    var pinAnnotationView: MKPinAnnotationView!
    
    var currentSelectedIndex: Int = 0 {
        didSet{
            let titleAtSelectedIndex = searchView.boroughArray[currentSelectedIndex]
            let loadJobCentersFromInternet: ([JobCenter]) -> Void = {(onlineJobCenters:[JobCenter]) in
                DispatchQueue.main.async {
                    self.jobCenters.removeAll()
                    self.searchView.mapView.removeAnnotations(self.annotations)
                    self.annotations.removeAll()
                    self.jobCenters = onlineJobCenters
                    if self.jobCenters.isEmpty{
                        self.noJobCentersAlert()
                    }
                }
            }
            JobCenterAPIClient.manager.getResourcesByBorough(with: titleAtSelectedIndex,
                                                             completionHandler: loadJobCentersFromInternet,
                                                             errorHandler: {print($0)})
        }
    }
    
    var jobCenters = [JobCenter](){
        didSet{
            // creating annotations
            for jobCenter in jobCenters {
                guard let jobLatitude = jobCenter.latitude,
                    let jobLongitude = jobCenter.longitude ,
                    let doubleLat = Double(jobLatitude),
                    let doubleLong = Double(jobLongitude) else {continue}
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(doubleLat, doubleLong)
                annotation.title = jobCenter.facilityName //this is the name that will show right unser the pin
                annotations.append(annotation)
            }
            // adding annotations to mapview - update ui
            DispatchQueue.main.async {
                self.searchView.mapView.addAnnotations(self.annotations)
                self.searchView.mapView.showAnnotations(self.annotations, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchView)
        setupNavBar()
        askUserForPermission()
        searchView.mapView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-list-filled-30 copy") , style: .plain, target: self, action: #selector(presentListVC))
        searchView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        //Zoom to user location
//        let noLocation = CLLocationCoordinate2D(latitude: -74.1197639, longitude: 40.6976637)
//        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
//        searchView.mapView.setRegion(viewRegion, animated: false)
    }
    
    //"Brooklyn", "Queens", "Bronx", "Manhattan", "Staten Island"
    @objc func segmentedControlValueChanged(segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex{
        case 0:
            currentSelectedIndex = 0
        case 1:
            currentSelectedIndex = 1
        case 2:
            currentSelectedIndex = 2
        case 3:
            currentSelectedIndex = 3
        case 4:
            currentSelectedIndex = 4
        default:
            print("This job center does not belong to  borough")
        }
    }
    @objc func presentListVC() {
        let listVC = ListViewController()
        listVC.jobCenters = self.jobCenters
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
    func askUserForPermission(){
        let _ = LocationService.manager.checkForLocationServices()
    }
    
    func setupNavBar(){
        navigationItem.title = "One-Stop-Shop"
        //Add right bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-list-filled-30 copy") , style: .plain, target: self, action: #selector(showListView))
    }
    
    @objc func showListView(){
        //present the List View
        let ListVC = ListViewController()
        present(ListVC, animated: true, completion: nil)
    }
}


//MARK: Maps delegate functions
extension SearchViewController: MKMapViewDelegate{
    
    //similar to cell for row at in table view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //setting up annotation views
        
        //setting up the blue dot
        if annotation is MKUserLocation{
            return nil
        }
        
        // setup annotation view for map
        // we can fully customize the marker annotation view
        var jobCenterAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "JobAnnotationView") //MKMarkerAnnotationView -> the view on top of the pin
        
        //if there is no annotation view, create a new one
        if jobCenterAnnotationView == nil {
            jobCenterAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "JobAnnotationView")
            jobCenterAnnotationView?.canShowCallout = true
            
            let index = annotations.index{$0 === annotation}
            
            if let annotationIndex = index {
                //let jobCenter = jobCenters[annotationIndex]
                //jobCenterAnnotationView?.glyphText = jobCenter.borough
                jobCenterAnnotationView?.image = #imageLiteral(resourceName: "orangeImage").reDrawImage(using: CGSize(width: 50, height: 50))//image is there.. It's just greyed out
                jobCenterAnnotationView?.contentMode = .scaleAspectFit
            }
            jobCenterAnnotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            jobCenterAnnotationView?.annotation = annotation
        }
        //TODO: For later: setting jobCenterAnnotationView's image
        return jobCenterAnnotationView
    }
    
    
    //similar to didSelect in tableviews
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //find the place selected and set that place to be the current place
        let index = annotations.index{$0 === view.annotation}
        guard let annotationIndex = index else { print("index is nil"); return }
        let jobCenter = jobCenters[annotationIndex]
        currentSelectedJobCenter = jobCenter
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //present the detail view controller
        let detailVC = DetailViewController(jobCenter: currentSelectedJobCenter)
        navigationController?.pushViewController(detailVC, animated: true)
        print("This is going to the List View Controller")
    }
}

//MARK: alerts
extension SearchViewController {
    func noJobCentersAlert(){
        let alertController = UIAlertController(title: "No Job Centers",
                                                message:"There are no job centers in this zipcode. Please search another zipcode",
                                                preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) //for other actions add in actions incompletion{}
        alertController.addAction(okAction)
        //present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
}
