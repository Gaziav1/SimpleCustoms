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
    var url: URL!
    private init(){}
    
    
    func getCountries(request: @escaping (Data?, Error?) -> Void) {
        
        guard let url = url else { print("url is not valid")
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            
            request(data, error)
            
            }.resume()
    }
    
    func fetchFlagsImages(for countryCode: String) -> UIImage? {
        var flagImage = UIImage()
        guard let urlForFlat = URL(string: "http://www.geognos.com/api/en/countries/flag/\(countryCode).png") else { return nil }
        let dataForFlatImage = try? Data(contentsOf: urlForFlat)
        guard let data = dataForFlatImage, let flatImage = UIImage(data: data) else { return nil }
        flagImage = flatImage
        return flagImage
    }
    
    
    func createUrl(for region: Regions) {
        switch region {
        case .americas:
            url = URL(string: "https://restcountries.eu/rest/v2/region/americas")
        case .asia:
            url = URL(string: "https://restcountries.eu/rest/v2/region/asia")
        case .europe:
            url = URL(string: "https://restcountries.eu/rest/v2/region/europe")
        case .oceania:
            url = URL(string: "https://restcountries.eu/rest/v2/region/oceania")
        }
    }
}

