//
//  NetworkDataFetcher.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 08/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation

class NetworkCountryFetcher {
    
    static var shared = NetworkCountryFetcher()
    
    private init(){}
    
    func fetchCountries(completionHandler: @escaping ([Country], [FlagImage]) -> Void) {
        NetworkManager.shared.getCountries { (data, error) in
            
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode([Country].self, from: data)
                var flagImages = [FlagImage]()
                for country in json {
                    let imageFlag = FlagImage(countryCode: country.alpha2Code)
                    flagImages.append(imageFlag)
                }
                DispatchQueue.main.async {
                    completionHandler(json, flagImages)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}


