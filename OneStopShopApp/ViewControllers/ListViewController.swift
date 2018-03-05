//
//  ListViewController.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit


class ListViewController: UIViewController {
    
    var listView = ListView()
    var emptyStateView = EmptyStateView()
    
    var jobCenters = [JobCenter](){
        didSet {
            listView.listTableView.reloadData()
        }
    }
    
    //Deselects the selected row
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectionIndexPath = listView.listTableView.indexPathForSelectedRow {
            self.listView.listTableView.deselectRow(at: selectionIndexPath, animated: animated)
            addConstraints()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.listTableView.dataSource = self
        listView.listTableView.delegate = self
        //listView.ListTableView.rowHeight = 50
        //view.addSubview(listView)
        configureNavigation()
        addConstraints()
        loadBoroughPicture()
        if jobCenters.isEmpty{
            self.view.addSubview(emptyStateView)
            emptyStateView.snp.makeConstraints({ (make) in
                make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
            })
            print("state added")
        } else {
            self.view.addSubview(listView)
        }
    }
    
    private func loadBoroughPicture(){
        if let firstBorough = jobCenters.first {
            switch firstBorough.borough {
            case "Manhattan":
                listView.listImageView.image = #imageLiteral(resourceName: "Pict_Manhattan")
            case "Bronx":
                listView.listImageView.image = #imageLiteral(resourceName: "Pict_Bronx")
            case "Brooklyn":
                listView.listImageView.image = #imageLiteral(resourceName: "Pict_Brooklyn")
            case "Queens":
                listView.listImageView.image = #imageLiteral(resourceName: "Pict_Queens")
            case "Staten Island":
                listView.listImageView.image = #imageLiteral(resourceName: "Pict_StatenIsland")
            default:
                break
            }
        } else {
            listView.listImageView.image = #imageLiteral(resourceName: "placeholder copy")
        }
    }
    
    private func configureNavigation(){
        guard let navTitle = jobCenters.first?.borough else {return}
        navigationItem.title = "\(navTitle) Resource Centers"
        navigationItem.leftItemsSupplementBackButton = false
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
    func addConstraints(){
        view.addSubview(listView)
        listView.snp.remakeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
}


//Extensions
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedJobCenter = jobCenters[indexPath.row]
        let detailVC = DetailViewController(jobCenter: selectedJobCenter)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobCenters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListTableViewCell {
            let jobCenter = jobCenters[indexPath.row]
            cell.selectionStyle = .none
            switch indexPath.row % 2 {
            case 0:
                cell.backgroundColor = UIColor(displayP3Red: 232 / 255, green: 234 / 255, blue: 237 / 255, alpha: 1)
            default:
                cell.backgroundColor = .white
            }
            cell.configureCell(jobCenter: jobCenter)
            return cell
        }
        return UITableViewCell()
    }
}





