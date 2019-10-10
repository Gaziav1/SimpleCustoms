//
//  CurrencyExchanger.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 06/10/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation

class CurrencyExchanger {
    
   private var valueToExchange: Int
   private var currency: Currency

   private var permissibleValue: Int {
        get {
            return 10000
        }
    }
    
    public var resultToShow: String {
         get {
             return String(exchange(valueToExchange, to: currency))
         }
     }
    
    init(valueToExchange: Int, currency: Currency) {
        self.valueToExchange = valueToExchange
        self.currency = currency
    }
    
    
    private func exchange(_ value: Int, to currency: Currency) -> Int {
        
        let exchagedValue = value / Int(currency.rates.RUB)
        return exchagedValue
    }
    
    func getResult() -> Bool {
        
        let exchangedCurrency = exchange(valueToExchange, to: currency)
        
        if exchangedCurrency <= permissibleValue {
            return true
        } else {
            return false
        }
    }
}
