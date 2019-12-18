//
//  CurrencyExchanger.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 06/10/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation

final class CurrencyExchanger {
    
   private var valueToExchange: Int
   private var currency: CurrencyToFetch
   private var permissibleValue: Int
    
   private var declarantValue: Int = 0
    
    public var isDeclarationNeeded: Bool {
        get {
            return declarantValue > permissibleValue
        }
    }
    
    
    init(valueToExchange: Int = 0, permissibleValue: Int = 10000, currency: CurrencyToFetch) {
        self.valueToExchange = valueToExchange
        self.currency = currency
        self.permissibleValue = permissibleValue
    }
    
    func setCurrentRates(_ currency: CurrencyToFetch) {
        self.currency = currency
    }
    
    func setPermissibleValue(_ value: Int) {
        self.permissibleValue = value
    }
    
    func setValueToExchange(_ value: Int) {
        self.valueToExchange = value
    }
    
    func exchange(_ reverse: Bool = false, value: Int) -> String {
        
        var exchangedValue: Int
        
        if reverse {
            exchangedValue = Int(Float(value) * Float(currency.rates.RUB))
            declarantValue = value
        } else {
            exchangedValue = Int(Float(value) * Float(currency.rates.RUB))
            declarantValue = exchangedValue
        }
      
        return String(exchangedValue)
    }
    
}
