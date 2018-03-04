//
//  PhoneTableViewCell.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class PhoneTableViewCell: UITableViewCell {

    lazy var phoneTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.backgroundColor = .white
        tv.textColor = .black
        tv.font = UIFont.systemFont(ofSize: 20)
        tv.dataDetectorTypes = .phoneNumber
        return tv
    }()
    
    lazy var leftTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "PhoneCell")
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
            
            addSubview(phoneTextView)
            phoneTextView.snp.makeConstraints({ (make) in
                make.trailing.equalTo(snp.trailing).offset(-8)
                make.centerY.equalTo(snp.centerY)
                make.width.equalTo(160)
                make.height.equalTo(60)
            })
        }
        
        
        
    }
    
}


