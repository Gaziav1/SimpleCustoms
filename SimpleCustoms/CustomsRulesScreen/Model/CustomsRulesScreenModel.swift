//
//  CustomsRulesScreenModel.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 12.12.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation
import RealmSwift

protocol CountryInfoForCell {
    var currency: String { get }
    var capital: String { get }
    var language: String { get }
}

protocol CountryInfo {
    var countryCode: String { get }
    var customsRules: List<CustomsRuleDescription> { get }
}


struct CustomsRulesScreenModel: CountryInfo, CountryInfoForCell {
    var currency: String
    var countryCode: String
    var capital: String
    var language: String
    var customsRules: List<CustomsRuleDescription>
    
    init(country: ShortCountryDescription, rules: List<CustomsRuleDescription>) {
        self.currency = country.currency
        self.capital = country.capital
        self.countryCode = country.countryCode
        
        self.language = country.language
        self.customsRules = rules
    }
    
}
