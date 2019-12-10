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
   private var currency: CurrencyToFetch

   private var permissibleValue: Int
    
    public var resultToShow: String {
         get {
             return String(exchange(valueToExchange, to: currency))
         }
     }
    
    init(valueToExchange: Int, permissibleValue: Int, currency: CurrencyToFetch) {
        self.valueToExchange = valueToExchange
        self.currency = currency
        self.permissibleValue = permissibleValue
    }
    
    
    private func exchange(_ value: Int, to currency: CurrencyToFetch) -> Int {
        
        let exchagedValue = value / Int(currency.rates.RUB)
        return exchagedValue
    }
    
    func getResult() -> Bool {
        
        let exchangedCurrency = exchange(valueToExchange, to: currency)
        
        return exchangedCurrency <= permissibleValue ? true : false
    
    }
}
