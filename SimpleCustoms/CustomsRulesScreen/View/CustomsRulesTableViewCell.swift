//
//  CustomsRulesTableViewCell.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 12/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class CustomsRulesTableViewCell: UITableViewCell {
    @IBOutlet weak var ruleHeader: UILabel!
    @IBOutlet weak var ruleBody: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let shapeLayer = CAShapeLayer()
       
        self.contentView.layer.addSublayer(shapeLayer)
        let path = UIBezierPath(roundedRect: CGRect(x: -20 , y: ruleHeader.frame.origin.y - 12, width: self.contentView.frame.width - 40, height: 50), cornerRadius: 30)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 0.1568627451, green: 0.2196078431, blue: 0.3529411765, alpha: 0.8960769747)
        let label = CATextLayer()
        label.frame = ruleHeader.frame
        label.fontSize = ruleHeader.font.pointSize
        label.font = ruleHeader.font
        label.string = ruleHeader.text
        label.shadowOpacity = 0
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowRadius = 4
        shapeLayer.shadowOpacity = 0.25
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        
        shapeLayer.addSublayer(label)
      
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
