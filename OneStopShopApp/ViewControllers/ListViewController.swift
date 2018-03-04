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
    
    var jobCenters = [JobCenter](){
        didSet {
            listView.listTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.listTableView.dataSource = self
        listView.listTableView.delegate = self
        configureNavigation()
        addConstraints()
        loadData()

    }
    
    private func loadData(){
//        JobCenterAPIClient.manager.getResources(with: "11220", completionHandler: { (onlineJobCenters) in
//            self.jobCenters = onlineJobCenters
//        }, errorHandler: {print ($0)})
        JobCenterAPIClient.manager.getResourcesByBorough(with: "Brooklyn", completionHandler: { (onlineJobCenter) in
            self.jobCenters = onlineJobCenter
        }, errorHandler: {print($0)})
    }
    
    private func configureNavigation(){
        view.backgroundColor = .white
            navigationItem.title = jobCenters.first?.borough
    }
    
    private func addConstraints(){
        view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//Extensions
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
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
