//
//  DescriptionTableViewCell.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 24.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var descriptionAnswer: UILabel!
    
    static let reuseId = "DescriptionCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
