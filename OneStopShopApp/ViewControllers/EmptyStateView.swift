//
//  EmptyStateView.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class EmptyStateView: UIView {
    
    lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Please select a borough to see your list of resource centers"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
        backgroundColor = .red
        setupViews()
        
    }
    
    private func setupViews(){
            addSubview(emptyStateLabel)
            emptyStateLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(snp.centerX)
                make.top.equalTo(safeAreaLayoutGuide.snp.bottom)
                make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
                make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            }
        
        }
    }
