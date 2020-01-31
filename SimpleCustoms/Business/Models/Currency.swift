//
//  Currency.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 09.12.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation
import RealmSwift

class Currency: Object {
    
    @objc dynamic var symbol: String?
    @objc dynamic var limit: Int = 0
    @objc dynamic var name: String?
    
}
