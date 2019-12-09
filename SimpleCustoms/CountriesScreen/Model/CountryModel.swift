//
//  CountryModel.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 05/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class Country: Decodable {
    var name: String
    var alpha2Code: String
    var region: String
    var currencies: [Currencies]
    var flagImages: FlagImage?
}

class Currencies: Decodable {
    var code: String?
    var name: String?
}

enum Regions: String, CaseIterable {
    case all = "All Countries"
    case europe = "Europe"
    case asia = "Asia"
}
