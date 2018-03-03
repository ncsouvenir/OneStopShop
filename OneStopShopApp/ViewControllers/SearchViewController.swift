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
    
    //var pointAnnotation: CustomPointAnnotation!
    var pinAnnotationView: MKPinAnnotationView!
    
    var jobCenters = [JobCenter](){
        didSet{
            // creating annotations
            for jobCenter in jobCenters {
                let annotation = MKPointAnnotation()
                                annotation.coordinate = CLLocationCoordinate2DMake(Double(jobCenter.latitude)!,
                                                                                   Double(jobCenter.longitude)!)
//                CLGeocoder().geocodeAddressString(jobCenter.streetAddress, completionHandler: { (placeMarks, error) in
//                    if let thisPlace = placeMarks?.last {
//                        annotation.coordinate = thisPlace.location!.coordinate
//                    }
//                })
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
        //set up delegates
        searchView.mapView.delegate = self
        searchView.zipCodeSearchBar.delegate = self
        askUserForPermission()
    }
    
    func askUserForPermission(){
        let _ = LocationService.manager.checkForLocationServices()
    }
    
    func setupNavBar(){
        navigationItem.title = "One-Stop-Shop"
        //Add right bar button
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "listIcon"), style: .plain, target: self, action: #selector(showListView))
        
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
        
        //        if annotation is MKUserLocation{
        //            return nil
        //        }
        
        // setup annotation view for map
        // we can fully customize the marker annotation view: customize!!
        var jobCenterAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "JobAnnotationView") as? MKMarkerAnnotationView //MKMarkerAnnotationView
        
        //if there is no annotation view, create a new one
        if jobCenterAnnotationView == nil {
            jobCenterAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "JobAnnotationView")
            jobCenterAnnotationView?.canShowCallout = true
            
            let index = annotations.index{$0 === annotation}
            
            if let annotationIndex = index {
                let jobCenter = jobCenters[annotationIndex]
                jobCenterAnnotationView?.glyphText = jobCenter.borough
                //jobCenterAnnotationView?.image = #imageLiteral(resourceName: "brain")
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
        print("This is going to the List View Controller")
    }
}

//MARK: Search bar delegate
extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        //validating the search by zipCode
        guard let text = searchView.zipCodeSearchBar.text else {print("job center search is nil");return}
        guard !text.isEmpty else {print("job center search is empty");return}
        guard let encodedJobCenterSearch = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {print("");return}
        //TODO: give error alert if no job centers exist
        
        if text.count != 5 {
            searchBar.text = ""
            //invalidZipCodeAlert()
            print("Invalid zipCode")
        }
        
        if text < String(00501) && text > String(99950) {
            //unknownZipCodeAlert()
            print("Unknown zipcode")
        }
        
        //completion
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
        //call API
        JobCenterAPIClient.manager.getResources(with: encodedJobCenterSearch,
                                                completionHandler: loadJobCentersFromInternet,
                                                errorHandler: {print($0)})
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
