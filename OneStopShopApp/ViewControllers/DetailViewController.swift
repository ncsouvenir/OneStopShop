//
//  DetailViewController.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UITableViewController {

    var jobCenter: JobCenter!
    var contentComponents = [ContentComponents]()
    
    init(jobCenter: JobCenter) {
        super.init(nibName: nil, bundle: nil)
        self.jobCenter = jobCenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        self.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailCell")
        self.tableView.register(MapTableViewCell.self, forCellReuseIdentifier: "MapCell")
       self.contentComponents = ContentFactory.getContentComponents(jobCenter: jobCenter)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
            let content = contentComponents[indexPath.row]
            cell.leftTextLabel.text = "Name"
            cell.rightTextLabel.text = content.detail
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
            let content = contentComponents[indexPath.row]
            cell.leftTextLabel.text = "Address"
            cell.rightTextLabel.text = content.detail
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
            let content = contentComponents[indexPath.row]
            cell.leftTextLabel.text = "Phone Number"
            cell.rightTextLabel.text = content.detail
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
            let content = contentComponents[indexPath.row]
            cell.leftTextLabel.text = "City"
            cell.rightTextLabel.text = content.detail
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as! MapTableViewCell
            cell.directionsButton.addTarget(self, action: #selector(showDirections), for: .touchUpInside)
            let annotation = MKPointAnnotation()
            annotation.coordinate = jobCenter.coordinate
            cell.mapV.addAnnotation(annotation)
            cell.mapV.showAnnotations(cell.mapV.annotations, animated: true)
            cell.mapV.centerCoordinate = jobCenter.coordinate
            cell.mapV.isScrollEnabled = false
            cell.selectionStyle = .none
            return cell
            
        default:
            return UITableViewCell()
        }
       
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 4:
            return 250
        default:
            return 50
        }
    }
    
    
    func configureNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favoriteButtonPressed))
    }
    
    
    @objc func showDirections() {
        let userCoordinate = CLLocationCoordinate2DMake(UserDefaultsHelper.manager.getLatitude(), UserDefaultsHelper.manager.getLongitude())
        let placeCoordinate = jobCenter.coordinate
        let directionsURLString = "http://maps.apple.com/?saddr=\(userCoordinate.latitude),\(userCoordinate.longitude)&daddr=\(placeCoordinate.latitude),\(placeCoordinate.longitude)"
        
        let url = URL(string: directionsURLString)!
        UIApplication.shared.open(url, options: [:]) { (done) in
            print("launched apple maps")
        }
        
    }
    
    @objc func favoriteButtonPressed() {
        PersistantManager.manager.addFavorite(newJob: self.jobCenter)
        showAlert()
    }
    func showAlert() {
        let alert = UIAlertController(title: "Added", message: "Successfully added the job center to favorites.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}


