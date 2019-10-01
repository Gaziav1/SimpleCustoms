//
//  NetworkDataFetcher.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 08/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation

final class NetworkCountryFetcher {
    
    static var shared = NetworkCountryFetcher()
    
    private init(){}
    
    func fetchCountries(completionHandler: @escaping ([Country]?, Error?) -> Void) {
        NetworkManager.shared.getCountries { (result) in
            
            switch result {
            case .failure(let error):
                completionHandler(nil, error)
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode([Country].self, from: data)
                    var jsonDataWithImages = [Country]()
                    
                    json.forEach { (country) in
                        let countryCopy = country
                        countryCopy.flagImages = FlagImage(countryCode: countryCopy.alpha2Code)
                        jsonDataWithImages.append(countryCopy)
                    }
                
                    DispatchQueue.main.async {
                        completionHandler(jsonDataWithImages, nil)
                    }
                    
                } catch let error {
                    completionHandler(nil, error)
                }
            }
        }
    }
}





