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
    lazy var starView: UIImageView = {
        let star = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        star.image = #imageLiteral(resourceName: "001-favorite")
        star.backgroundColor = .clear
        star.alpha = 0
        return star
    }()
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
        setStarConstrain()
          view.backgroundColor = .green
        self.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailCell")
        self.tableView.register(MapTableViewCell.self, forCellReuseIdentifier: "MapCell")
        self.tableView.register(PhoneTableViewCell.self, forCellReuseIdentifier: "PhoneCell")
       self.contentComponents = ContentFactory.getContentComponents(jobCenter: jobCenter)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }

    private func setStarConstrain() {
        view.addSubview(starView)
        starView.translatesAutoresizingMaskIntoConstraints = false
        starView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        starView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: (UIScreen.main.bounds.width / 2) - 35).isActive = true
        starView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        starView.widthAnchor.constraint(equalToConstant: 35).isActive = true
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
                cell.backgroundColor = UIColor(displayP3Red: 232 / 255, green: 234 / 255, blue: 237 / 255, alpha: 1)
            cell.selectionStyle = .none
            
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
            let content = contentComponents[indexPath.row]
            cell.leftTextLabel.text = "Address"
            cell.rightTextLabel.text = content.detail
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath) as! PhoneTableViewCell
            let content = contentComponents[indexPath.row]
            cell.leftTextLabel.text = "Phone Number"
            cell.phoneTextView.text = content.detail
           cell.backgroundColor = UIColor(displayP3Red: 232 / 255, green: 234 / 255, blue: 237 / 255, alpha: 1)
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
            let content = contentComponents[indexPath.row]
            cell.leftTextLabel.text = "City"
            cell.rightTextLabel.text = content.detail
            cell.selectionStyle = .none
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
            cell.backgroundColor = UIColor(displayP3Red: 232 / 255, green: 234 / 255, blue: 237 / 255, alpha: 1)
            cell.selectionStyle = .none
            return cell
            
        default:
            return UITableViewCell()
        }
       
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 4:
            return 425
        default:
            return 50
        }
    }
    
    
    func configureNavBar() {
       let index = PersistantManager.manager.getFavotites().index(where: {self.jobCenter.phoneNumber == $0.phoneNumber})
        if index == nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "002-star"), style: .plain, target: self, action:  #selector(favoriteButtonPressed))
        } else {
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "001-star-1"), style: .plain, target: self, action:  #selector(favoriteButtonPressed))
        }
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
        switch navigationItem.rightBarButtonItem!.image! {
        case #imageLiteral(resourceName: "002-star"):
            PersistantManager.manager.addFavorite(newJob: self.jobCenter)
            animateStar()
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "001-star-1"), style: .plain, target: self, action:  #selector(favoriteButtonPressed))
        default:
            showAlert(title: "Already favorited", message: "This resource center is already favorited")
        }
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func animateStar() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.toValue = starView.alpha = 1
        //animation.fromValue = self.starView.layer.position
        animation.toValue = CGPoint(x: UIScreen.main.bounds.width - 100, y: UIScreen.main.bounds.height)
        animation.duration = 1
        animation.repeatCount = 1
      starView.layer.add(animation, forKey: nil)
    }
}

extension DetailViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        starView.alpha = 0
    }
}


