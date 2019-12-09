//
//  CustomsRules.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 24/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation
import RealmSwift


class CustomsRules: Object {
    
    @objc dynamic var forCountryCode: String?
    var customsRule = List<CustomsRuleDescription>()
    var goodsLimitations = List<GoodsWithLimitations>()
}

class CustomsRuleDescription: Object {
    @objc dynamic var header = ""
    @objc dynamic var body = ""
}

