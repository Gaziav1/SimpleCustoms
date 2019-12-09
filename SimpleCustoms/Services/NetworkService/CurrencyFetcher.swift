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
    
    
    func getCurrency(currency: String, completion: @escaping (Currency?, Error?) -> Void) {
        
        let urlPath = APIPath(scheme: "https", endpoint: "api.ratesapi.io", path: "/api/latest", params: ["base": currency,
            "symbols": "RUB"])
        
        guard let completeURL = urlPath.fullURL else { return }
        
        NetworkManager.shared.makeRequest(url: completeURL) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .failure(let error):
                    completion(nil, error)
                case .success(let data):
                    do {
                        let json = try JSONDecoder().decode(Currency.self, from: data)
                        completion(json, nil)
                    } catch let error {
                        completion(nil, error)
                    }
                }
            }
        }
    }
}
