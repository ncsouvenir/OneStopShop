//
//  FavoritesViewController.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    var favoritesView = FavoritesView()
    
    var jobCenters = [JobCenter](){
        didSet {
            favoritesView.FavoritesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        favoritesView.FavoritesTableView.dataSource = self
        favoritesView.FavoritesTableView.delegate = self
        favoritesView.FavoritesTableView.rowHeight = 100
        configureNavigation()
        addConstraints()
        loadData()
        
    }
    
    private func loadData(){
        
    }
    
    private func configureNavigation(){
        view.backgroundColor = .blue
        navigationItem.title = "Favorite Centers "
    }
    
    private func addConstraints(){
        view.addSubview(favoritesView)
        favoritesView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    
}
extension FavoritesViewController: UITableViewDelegate {
    
}
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobCenters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as? ListTableViewCell {
            let jobCenter = jobCenters[indexPath.row]
            cell.configureCell(jobCenter: jobCenter)
            return cell
        }
        return UITableViewCell()
    }
    
    
}



