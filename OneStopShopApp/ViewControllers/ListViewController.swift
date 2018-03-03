//
//  ListViewController.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    var listView = ListView()
    var jobCenters = [JobCenter](){
        didSet {
            listView.ListTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.ListTableView.dataSource = self
        listView.ListTableView.delegate = self
        listView.ListTableView.rowHeight = 97.5
        configureNavigation()
        loadData()

    }
    
    private func loadData(){
        
    }
    
    private func configureNavigation(){
        view.backgroundColor = .red
            navigationItem.title = "List of Job Centers "
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ListViewController: UITableViewDelegate {
    
}
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobCenters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListTableViewCell {
            let jobCenter = jobCenters[indexPath.row]
            cell.configureCell(jobCenter: jobCenter)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
