//
//  RegionCollectionViewCell.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 26.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import TinyConstraints

class RegionCollectionViewCell: UICollectionViewCell {
    
    let regionName: UILabel = {
        let label = UILabel()
        label.text = "Europe"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let reuseId = "RegionCell"
    
    
    override var isSelected: Bool {
        didSet {
            if #available(iOS 13.0, *) {
                regionName.textColor = isSelected ? .systemIndigo : .lightGray
            } else {
                regionName.textColor = isSelected ? #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1) : .lightGray
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLabel() {
        contentView.addSubview(regionName)
        
        regionName.center(in: contentView)
    }
    
}
