//
//  GoodsTableViewCell.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 01.12.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class CountryChooserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleOfLabel: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var choosenEntity: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var chevron: UIImageView!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 5
            containerView.layer.masksToBounds = true
        }
    }

    var indexPath = 0 {
        didSet {
            defineContentForCell()
        }
    }
    
    static let cellId = "CountryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
        } else {
            backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        }
        animateCircles()
    }
    
    func animatedLine() {
        
        if indexPath == 2 {
            return
        }
        
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: 25.5, y: 44))
        aPath.addLine(to: CGPoint(x: 25.5, y: contentView.frame.maxY))
        
        aPath.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = aPath.cgPath
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 2
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        animation.duration = 0.3
        shapeLayer.add(animation, forKey: "strokeEnd")
        
        contentView.layer.addSublayer(shapeLayer)
    }
    
    func animateCircles() {
        
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 5.5, y: 2, width: 40, height: 40)).cgPath
        circleLayer.path = circlePath
        circleLayer.fillColor = .none
        if #available(iOS 13.0, *) {
            circleLayer.strokeColor = UIColor.label.cgColor
        } else {
            circleLayer.strokeColor = UIColor.black.cgColor
        }
        circleLayer.strokeEnd = 0
        circleLayer.lineWidth = 2
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        animation.duration = 0.2
        animation.delegate = self
        circleLayer.add(animation, forKey: "strokeEnd")
        
        contentView.layer.insertSublayer(circleLayer, at: 0)
    }
    
    private func defineContentForCell() {
        
       
        switch indexPath {
        case 1:
            type.text = "Товар"
            titleOfLabel.text = "Выберите товар"
            type.fadeIn()
            titleOfLabel.fadeIn()
            containerView.fadeIn()
            chevron.fadeIn()
        case 2:
            titleOfLabel.text = "Результат"
            titleOfLabel.font = UIFont.systemFont(ofSize: 22)
            type.fadeIn()
            titleOfLabel.fadeIn()
            containerView.fadeIn()
            if #available(iOS 13.0, *) {
                type.textColor = .label
            } else {
                type.textColor = .white
            }
        default:
            type.fadeIn()
            titleOfLabel.fadeIn()
            containerView.fadeIn()
            flagImage.fadeIn()
            chevron.fadeIn()
            choosenEntity.fadeIn()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension CountryChooserTableViewCell: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animatedLine()
        
    }
}
