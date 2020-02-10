//
//  MainScreenTableViewCell.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 10/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import SDWebImage

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImage: UIImageView! 
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flagImage.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(with info: Country) {
        countryName.text = info.name

        guard let urlForImage = URL(string: "https://countryflags.io/\(info.alpha2Code.lowercased())/flat/64.png") else { return }
        flagImage.sd_setImage(with: urlForImage) { [weak self] _, _, _, _ in
            self?.flagImage.fadeIn()
        }
    }
}
