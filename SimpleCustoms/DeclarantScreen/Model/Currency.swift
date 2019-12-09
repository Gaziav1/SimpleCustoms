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
    
    @objc dynamic var symbol = ""
    @objc dynamic var limit = 0
    @objc dynamic var name = ""
    
}
