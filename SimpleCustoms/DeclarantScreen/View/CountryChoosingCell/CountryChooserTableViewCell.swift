//
//  GoodsTableViewCell.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 01.12.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class CountryChooserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var choosenEntity: UILabel!
    @IBOutlet weak var flagImage: UIImageView?
    @IBOutlet weak var chevron: UIImageView!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 5
            containerView.layer.masksToBounds = true
        }
    }

    @IBOutlet weak var trailingChoosenGoods: NSLayoutConstraint!
    @IBOutlet weak var superViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    static let cellId = "CountryCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        animationHandler()
    }
    
    func animationHandler() {
          
          let aPath = UIBezierPath()
          
          aPath.move(to: CGPoint(x: 25.5, y: 43))
          
          aPath.addLine(to: CGPoint(x: 25.5, y: 145))
          
          aPath.close()

          let shapeLayer = CAShapeLayer()
          shapeLayer.path = aPath.cgPath
          shapeLayer.strokeColor = UIColor.lightGray.cgColor
          shapeLayer.lineWidth = 1.0
        
          let circleLayer = CAShapeLayer();
        circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 5.5, y: 0, width: 40, height: 40)).cgPath
          if #available(iOS 13.0, *) {
            circleLayer.fillColor = UIColor.systemIndigo.cgColor
          } else {
            circleLayer.fillColor = UIColor.black.cgColor
          }
          
          contentView.layer.addSublayer(shapeLayer)
          contentView.layer.insertSublayer(circleLayer, at: 0)
      }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
