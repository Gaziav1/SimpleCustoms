//
//  CurrencyFetcher.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 06/10/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation

class CurrencyFetcher {
    
    static var shared = CurrencyFetcher()
    
    
    func getCurrency(completion: @escaping (Currency?, Error?) -> Void) {
    
        guard let url = URL(string: "https://api.ratesapi.io/api/latest?symbols=RUB") else { print("no")
            return }
        
        NetworkManager.shared.makeRequest(url: url) { (result) in
            
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(nil, error)
                    print("error")
                }
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(Currency.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(json, nil)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
    }
}
