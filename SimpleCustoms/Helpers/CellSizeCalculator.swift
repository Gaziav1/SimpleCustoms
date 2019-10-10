//
//  CellSizeCalculator.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 23/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit


private struct Constans {
    static let topViewHeight: CGFloat = 47
    static let customsRulesLabelInsets = UIEdgeInsets(top: 8 + Constans.topViewHeight + 13, left: 18, bottom: 10, right: 18)
    static let customsRulesLabelFont = UIFont.systemFont(ofSize: 19)
    static var screenWidth: CGFloat {
         return UIScreen.main.bounds.width
     }
}

class CustomsRulesCellLayout {
    
    static let shared = CustomsRulesCellLayout()
    
    lazy var totalHeight: CGFloat = 0.0
    
    private init(){}
    
    func size(for customsRule: String) -> CGRect {
           
        let width = Constans.screenWidth - Constans.customsRulesLabelInsets.left - Constans.customsRulesLabelInsets.right
        
        let customsRulesLabelFrame: CGRect = CGRect(origin: CGPoint(x: Constans.customsRulesLabelInsets.left, y: Constans.customsRulesLabelInsets.top), size: CGSize(width: width, height: customsRule.height(width: width, font: Constans.customsRulesLabelFont)))
        
        totalHeight = customsRulesLabelFrame.maxY
        
        return customsRulesLabelFrame
    }
}



