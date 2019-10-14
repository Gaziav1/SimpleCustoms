//
//  CurrencyExchanger.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 06/10/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation

class Currency: Decodable {
    var rates: RubCurrency
}

class RubCurrency: Decodable {
    var RUB: Float
}
