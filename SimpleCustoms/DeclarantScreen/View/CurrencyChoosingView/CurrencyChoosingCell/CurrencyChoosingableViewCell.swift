//
//  CurrencyChoosingableViewCell.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 08.12.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class CurrencyChoosingableViewCell: UITableViewCell {
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
