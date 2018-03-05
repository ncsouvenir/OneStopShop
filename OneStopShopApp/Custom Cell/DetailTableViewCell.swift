//
//  DetailTableViewCell.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class DetailTableViewCell: UITableViewCell {

    
    lazy var leftTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var rightTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "DetailCell")
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        addSubview(leftTextLabel)
        
        leftTextLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(snp.leading).offset(8)
            make.centerY.equalTo(snp.centerY)
            
            addSubview(rightTextLabel)
            rightTextLabel.snp.makeConstraints({ (make) in
                make.trailing.equalTo(snp.trailing).offset(-8)
                make.centerY.equalTo(snp.centerY)
            })
            
        }
      
        
    }

    
    

}
