//
//  MainScreenTableViewCell.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 10/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    static let reuseId = "CountryCell"

    @IBOutlet weak var flagImage: UIImageView! 
    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var countryView: UIView!
    
    override var isSelected: Bool {
           didSet {
               countryView.backgroundColor = isHighlighted ? #colorLiteral(red: 0.1490196078, green: 0.8156862745, blue: 0.4862745098, alpha: 1) : #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9450980392, alpha: 1)
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flagImage.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
