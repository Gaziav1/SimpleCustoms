//
//  CountryModel.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 05/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

struct Country: Decodable {
    var name: String
    var alpha2Code: String
    var region: String
    var currencies: [Currencies]
    var capital: String
    var languages: [Languages]
}



