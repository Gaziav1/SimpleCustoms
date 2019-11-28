//
//  RulesCollectionViewCell.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 24.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class RulesCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 15
            contentView.layer.masksToBounds = true
            backgroundColor = .clear
            dropShadow(scale: true, shadowOffset: CGSize(width: 1, height: 3), opacity: 0.4, radius: 3)
        }
    }
    
    @IBOutlet weak var headerContainer: UIView!  {
        didSet {
             containerView.layer.cornerRadius = 13
             containerView.layer.masksToBounds = true
        }
    }
    static let reuseId = "RulesCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
