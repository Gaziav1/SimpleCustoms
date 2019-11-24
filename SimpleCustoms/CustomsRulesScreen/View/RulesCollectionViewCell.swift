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

    
    static let reuseId = "RulesCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
