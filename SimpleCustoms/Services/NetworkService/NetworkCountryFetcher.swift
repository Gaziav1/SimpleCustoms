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
    
    func fetchCountries(completionHandler: @escaping ([Country]?, [FlagImage]?, Error?) -> Void) {
        NetworkManager.shared.getCountries { (result) in
            
            switch result {
            case .failure(let error):
                completionHandler(nil, nil, error)
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode([Country].self, from: data)
                    var flagImages = [FlagImage]()
                    for country in json {
                        let imageFlag = FlagImage(countryCode: country.alpha2Code)
                        flagImages.append(imageFlag)
                    }
                    DispatchQueue.main.async {
                        completionHandler(json, flagImages, nil)
                    }
                } catch let error {
                    completionHandler(nil, nil, error)
                }
            }
        }
    }
}





