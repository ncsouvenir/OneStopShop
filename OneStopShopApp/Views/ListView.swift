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

    
    lazy var ListTableView: UITableView = {
        let tv = UITableView()
        tv.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")
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
        backgroundColor = .white
 
        setupViews()
       
    }
    
    
    
    private func setupViews(){
        addSubview(ListTableView)
        ListTableView.snp.makeConstraints { (tableView) in
            tableView.edges.equalTo(snp.edges)
        }
    
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
