//
//  NetworkDataFetcher.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 08/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation

let networkCallGroup = DispatchGroup() //нужно для выполнения двух запросов последовательно и передачи данных по их окончанию

final class NetworkCountryFetcher {
    
    static var shared = NetworkCountryFetcher()
    private var apiPaths = [APIPath(scheme: "https",
                                    endpoint: "restcountries.eu",
                                    path: "/rest/v2/region/europe",
                                    params: nil),
                            APIPath(scheme: "https",
                                    endpoint: "restcountries.eu",
                                    path: "/rest/v2/region/asia",
                                    params: nil)]
    private init(){}
    
    func fetchCountries(completionHandler: @escaping ([Country]?, Error?) -> Void) {
        
        var jsonData = [Country]()
        var networkError: Error?
        
        for region in apiPaths {
            guard let url = region.fullURL else { return }
            
            networkCallGroup.enter()
            NetworkManager.shared.makeRequest(url: url) { (result) in
                
                switch result {
                case .failure(let error):
                    networkError = error
                case .success(let data):
                    do {
                        let json = try JSONDecoder().decode([Country].self, from: data)
                        json.forEach { (country) in
                            guard let countryCopy = self.filter(country) else { return }
                            countryCopy.flagImages = FlagImage(countryCode: countryCopy.alpha2Code)
                            jsonData.append(countryCopy)
                        }
                    } catch let error {
                        networkError = error
                    }
                }
                networkCallGroup.leave()
            }
        }
        
        networkCallGroup.notify(queue: .main) {
            if networkError == nil {
                completionHandler(jsonData, nil)
            } else {
                completionHandler(nil, networkError)
            }
        }
    }
    
    func fetchFlagsImages(for countryCode: String, of type: ImageType, completion: @escaping (Data?) -> Void) {
        WebImageHandler.getImage(for: countryCode, of: type) { (data) in
            completion(data)
        }
    }
    
    private func filter(_ country: Country) -> Country? {
        switch country.alpha2Code {
        case "UA":
            return nil
        case "GB":
            let countryCopy = country
            countryCopy.name = "United Kingdom"
            return countryCopy
        case "RU":
            return nil
        case "XK":
            return nil
        case "MK":
            let countryCopy = country
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
            let countryCopy = country
            countryCopy.name = "North Korea"
            return countryCopy
        case "KR":
            let countryCopy = country
            countryCopy.name = "South Korea"
            return countryCopy
        default:
            return country
        }
    }
}





