//
//  MapTableViewCell.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class MapTableViewCell: UITableViewCell {
    
    lazy var mapV: MKMapView = {
        let mv = MKMapView()
        mv.clipsToBounds = true
        return mv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MapCell")
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpView() {
        setUpMap()
    }
    
    func setUpMap() {
        addSubview(mapV)
        mapV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.equalTo(safeAreaLayoutGuide).offset(5)
            make.right.equalTo(safeAreaLayoutGuide).offset(-5)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    
}
