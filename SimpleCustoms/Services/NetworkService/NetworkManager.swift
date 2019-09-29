//
//  NetworkManager.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 05/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let session = URLSession(configuration: .default)
    private var url = URL(string: "https://restcountries.eu/rest/v2/region/europe")
    private init(){}
    
    
    func getCountries(request: @escaping (Data?, Error?) -> Void) {
        
        guard let url = url else { print("url is not valid")
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
          
            request(data, error)
        }.resume()
    }
    
    func fetchFlagsImages(for countryCode: String) -> [UIImage?] {
        return WebImageHandler.prepareImages(countryCode: countryCode)
    }
}
