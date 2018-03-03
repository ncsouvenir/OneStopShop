//
//  FavoritesView.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FavoritesView: UIView {
<<<<<<< HEAD

=======
    
>>>>>>> bf38a552083692a7f50e5d938be64237a307dd35
    lazy var FavoritesTableView: UITableView = {
        let tv = UITableView()
        tv.register(ListTableViewCell.self, forCellReuseIdentifier: "FavoritesCell")
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
<<<<<<< HEAD
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews(){
        addSubview(FavoritesTableView)
        
        FavoritesTableView.snp.makeConstraints { (tableView) in
            tableView.edges.equalTo(snp.edges)
        }
    }

=======
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews(){
        addSubview(FavoritesTableView)
        
        FavoritesTableView.snp.makeConstraints { (tableView) in
            tableView.edges.equalTo(snp.edges)
        }
    }
    
>>>>>>> bf38a552083692a7f50e5d938be64237a307dd35
}

