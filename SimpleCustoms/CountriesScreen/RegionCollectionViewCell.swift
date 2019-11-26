//
//  RegionCollectionViewCell.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 26.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class RegionCollectionViewCell: UICollectionViewCell {
    
    let regionName: UILabel = {
        let label = UILabel()
        label.text = "Europe"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let reuseId = "RegionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLabel() {
        contentView.addSubview(regionName)
        
        regionName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        regionName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
}
