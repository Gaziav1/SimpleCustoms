//
//  CellModel.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 12.12.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation

protocol CellData {
    var countryName: String { get }
    var countryCode: String { get }
}

protocol ShortCountryDescription {
    var countryCode: String { get }
    var currency: String { get }
    var capital: String { get }
    var language: String { get }
}

struct CountryScreenModel: CellData, ShortCountryDescription {
    var countryName: String
    var countryCode: String
    var currency: String
    var capital: String
    var language: String
    
    init(country: Country) {
        self.countryName = country.name
        self.countryCode = country.alpha2Code
        self.currency = country.currencies[0].name ?? "Не определенно"
        self.capital = country.capital
        self.language = country.languages[0].name
    }
}
