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
    var flagImages: FlagImage?
}

enum Regions: String, CaseIterable {
    case all = "All Countries"
    case europe = "Europe"
    case asia = "Asia"
}
