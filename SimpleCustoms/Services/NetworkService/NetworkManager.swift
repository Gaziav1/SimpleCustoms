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
    private var url = URL(string: "https://restcountries.eu/rest/v2/region/europe")
    private init(){}
    
    
    func getCountries(request: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = url else { print("url is not valid")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                request(.failure(error!))
                return
            }
           
            request(.success(data!))
            
        }
        dataTask.resume()
    }
    
    func fetchFlagsImages(for countryCode: String, of type: ImageType) -> UIImage? {
        return WebImageHandler.getImage(for: countryCode, of: type)
    }
}
