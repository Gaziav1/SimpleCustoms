//
//  CountryModel.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 05/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

protocol ShortDescriptionOfCountry {
    var currencies: String { get }
    var capital: String { get }
    var languages: String { get }
}

struct Country: Decodable, ShortDescriptionOfCountry {
    var name: String
    var alpha2Code: String
    var region: String
    var currencies: [Currencies]
    var capital: String
    var languages: [Languages]
    var flagImages: FlagImage?
}

struct Currencies: Decodable {
    var code: String?
    var name: String?
}

struct Languages: Decodable {
    var name: String
}

enum Regions: String, CaseIterable {
    case all = "All Countries"
    case europe = "Europe"
    case asia = "Asia"
}
