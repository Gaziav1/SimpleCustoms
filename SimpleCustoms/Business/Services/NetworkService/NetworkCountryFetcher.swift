//
//  NetworkDataFetcher.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 08/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation
import SDWebImage

protocol CountryFetcher {
    func fetchCountries(completionHandler: @escaping ([Country]?, Error?) -> Void)
}

final class NetworkCountryFetcher: CountryFetcher {
    
    private let networkManager: Networking
    
    init(networkHandler: Networking = NetworkManager()) {
        self.networkManager = networkHandler
    }
    
    func fetchCountries(completionHandler: @escaping ([Country]?, Error?) -> Void) {
        
        var jsonData = [Country]()
        
        for region in APIPath.FullUrl.allCases {
            guard let url = region.fullUrlForCountries else { return }
            
            networkManager.getData(url: url) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        completionHandler(nil, error)
                    case .success(let data):
                        do {
                            let json = try JSONDecoder().decode([Country].self, from: data)
                            
                            json.forEach { (country) in
                                guard let countryCopy = self.filter(country) else { return }
                                jsonData.append(countryCopy)
                            }
                            completionHandler(jsonData, nil)
                        } catch let error {
                            completionHandler(nil, error) 
                        }
                    }
                }
            }
        }
    }
}

extension NetworkCountryFetcher {
    private func filter(_ country: Country) -> Country? {
        switch country.alpha2Code {
        case "UA":
            return nil
        case "GB":
            var countryCopy = country
            countryCopy.name = "United Kingdom"
            return countryCopy
        case "RU":
            return nil
        case "XK":
            return nil
        case "MK":
            var countryCopy = country
            countryCopy.name = "Macedonia"
            return countryCopy
        case "AF":
            return nil
        case "IQ":
            return nil
        case "KZ":
            return nil
        case "MO":
            return nil
        case "PS":
            return nil
        case "SY":
            return nil
        case "TJ":
            return nil
        case "TL":
            return nil
        case "AE":
            return nil
        case "YE":
            return nil
        case "HK":
            return nil
        case "KP":
            var countryCopy = country
            countryCopy.name = "North Korea"
            return countryCopy
        case "KR":
            var countryCopy = country
            countryCopy.name = "South Korea"
            return countryCopy
        default:
            return country
        }
    }
}





