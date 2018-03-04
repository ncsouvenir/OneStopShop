//
//  DetailViewController.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

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
       self.contentComponents = ContentFactory.getContentComponents(jobCenter: jobCenter)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentComponents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
        let content = contentComponents[indexPath.row]
        switch indexPath.row {
        case 0 :
            cell.leftTextLabel.text = "Name"
            cell.rightTextLabel.text = content.detail
        case 1:
            cell.leftTextLabel.text = "Address"
            cell.rightTextLabel.text = content.detail
        case 2:
            cell.leftTextLabel.text = "Phone Number"
            cell.rightTextLabel.text = content.detail
        case 3:
            cell.leftTextLabel.text = "City"
            cell.rightTextLabel.text = content.detail
        default:
            print("error")
        }
        return cell
    }
    
    
    func configureNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favoriteButtonPressed))
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


