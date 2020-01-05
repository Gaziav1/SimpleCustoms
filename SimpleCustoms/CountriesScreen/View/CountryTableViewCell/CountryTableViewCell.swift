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
    
    func fillCell(with info: CellData) {
        countryName.text = info.countryName
        let url = APIPath(scheme: "https", endpoint: "www.countryflags.io", path: "/\(info.countryCode.lowercased())/flat/64.png", params: nil)
        guard let urlForImage = url.fullURL else { return }
        flagImage.sd_setImage(with: urlForImage) { (_, _, _, _) in
            self.flagImage.fadeIn()
        }
        
    }

}
