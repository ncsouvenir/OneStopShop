//
//  ListView.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
class ListView: UIView {

    
    lazy var listTableView: UITableView = {
        let tv = UITableView()
        tv.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")
        tv.tableFooterView = UIView(frame: .zero)
        return tv
    }()
    lazy var listImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "placeholder copy")
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        addSubview(listImageView)
        addSubview(listTableView)
       
        
        listImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.width.equalTo(snp.width)
            //make.height.equalTo(snp.height).multipliedBy(0.4)
            make.bottom.equalTo(listTableView.snp.top)
            
        }
        listTableView.snp.makeConstraints { (tableView) in
            tableView.top.equalTo(listImageView.snp.bottom)
            tableView.width.equalTo(snp.width)
            tableView.height.equalTo(snp.height).multipliedBy(0.6)
            tableView.bottom.equalTo(snp.bottom)
        }
    }

}
