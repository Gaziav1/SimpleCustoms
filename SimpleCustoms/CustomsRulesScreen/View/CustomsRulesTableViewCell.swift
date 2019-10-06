//
//  CustomsRulesTableViewCell.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 12/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class CustomsRulesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var blur: UIVisualEffectView! {
        didSet {
            blur.layer.cornerRadius = 25
            blur.layer.masksToBounds = true
        }
    }
    
    static var reuseIdentifier = "CustomsCell"
    
    @IBOutlet weak var customsHeaderView: UIView! {
        didSet {
            customsHeaderView.layer.cornerRadius = 25
            customsHeaderView.layer.masksToBounds = true
            customsHeaderView.dropShadow()
        }
    }
    @IBOutlet weak var rulesLabel: UILabel! {
        didSet {
        
        }
    }
    
    @IBOutlet weak var rulesTypeLabel: UILabel!
    @IBOutlet weak var rulesIcon: UIImageView! {
        didSet {
            rulesIcon.contentMode = .scaleAspectFit
            rulesIcon.image = #imageLiteral(resourceName: "wallet")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
