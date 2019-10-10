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
    private var url = URL(string: "https://restcountries.eu/rest/v2/region/europe")
    private init(){}
    
    func fetchCountries(completionHandler: @escaping ([Country]?, Error?) -> Void) {
        
        guard let url = url else { return }
        
        NetworkManager.shared.makeRequest(url: url) { (result) in
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode([Country].self, from: data)
                    var jsonDataWithImages = [Country]()
                    
                    json.forEach { (country) in
                        guard let countryCopy = self.filter(country) else { return }
                        
                        countryCopy.flagImages = FlagImage(countryCode: countryCopy.alpha2Code)
                        jsonDataWithImages.append(countryCopy)
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(jsonDataWithImages, nil)
                    }
                    
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(nil, error)
                    }
                }
            }
        }
    }
    
    func fetchFlagsImages(for countryCode: String, of type: ImageType, completion: @escaping (Data?) -> Void) {
        return WebImageHandler.getImage(for: countryCode, of: type) { (data) in
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
        case "SM":
            return nil
        case "MK":
            let countryCopy = country
            countryCopy.name = "Macedonia"
            return countryCopy
        default:
            return country
        }
    }
}





