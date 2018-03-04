//
//  FavoritesViewController.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//
import UIKit
import SnapKit
class FavoritesViewController: UIViewController {
    var favoritesView = FavoritesView()
    
    var jobCenters = [JobCenter](){
        didSet {
            favoritesView.FavoritesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Favorites"
        favoritesView.FavoritesTableView.dataSource = self
        favoritesView.FavoritesTableView.delegate = self
        //favoritesView.FavoritesTableView.rowHeight = 100
        configureNavigation()
        addConstraints()
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.jobCenters = PersistantManager.manager.getFavotites()
    }
    
    private func loadData(){
        self.jobCenters = PersistantManager.manager.getFavotites()
    }
    
    private func configureNavigation(){
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedJobCenter = jobCenters[indexPath.row]
        let detailVC = DetailViewController(jobCenter: selectedJobCenter)
        navigationController?.pushViewController(detailVC, animated: true)
    }
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if !jobCenters.isEmpty {
            return true
        }
        return false
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       if !jobCenters.isEmpty {
        if editingStyle == .delete {
            tableView.beginUpdates()
            jobCenters.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            PersistantManager.manager.removeFavorite(from: indexPath.row)
            tableView.endUpdates()
        }
    }
}

}
