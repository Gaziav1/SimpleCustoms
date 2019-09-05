//
//  NetworkManager.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 05/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let session = URLSession(configuration: .default)
    private init(){}
    
    
    func getCountries(for region: Regions) {
        
        var baseUrl: URL!
        
        switch region {
        case .americas:
            baseUrl = URL(string: "https://restcountries.eu/rest/v2/region/americas")
        case .asia:
            baseUrl = URL(string: "https://restcountries.eu/rest/v2/region/asia")
        case .europe:
            baseUrl = URL(string: "https://restcountries.eu/rest/v2/region/europe")
        case .oceania:
            baseUrl = URL(string: "https://restcountries.eu/rest/v2/region/oceania")
            
        }
        
        guard let url = baseUrl else { print("url is not valid")
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
           
            guard let data = data else { return }
         
            do {
                let json = try JSONDecoder().decode([Country].self, from: data)
                print(json)
                print(json[0].name)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
