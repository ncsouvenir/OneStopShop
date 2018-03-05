//
//  FavoritesView.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FavoritesView: UIView {

    lazy var FavoritesTableView: UITableView = {
        let tv = UITableView()
        tv.register(ListTableViewCell.self, forCellReuseIdentifier: "FavoritesCell")
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
         backgroundColor = .green
        setupViews()
    }
    
    private func setupViews(){
        addSubview(FavoritesTableView)
        
        FavoritesTableView.snp.makeConstraints { (tableView) in
            tableView.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }


    }





