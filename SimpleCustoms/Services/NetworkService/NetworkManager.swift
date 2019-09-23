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
        
        createUrl(for: .europe)
        guard let url = url else { print("url is not valid")
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            
            request(data, error)
            
            }.resume()
    }
    
    func fetchFlagsImages(for countryCode: String) -> [UIImage] {
        var flatFlagImage = UIImage()
        var shinyFlagImage = UIImage()
        guard let urlForFlat = URL(string: "https://www.countryflags.io/\(countryCode)/flat/64.png"), let urlForShiny = URL(string: "https://www.countryflags.io/\(countryCode)/shiny/64.png") else { return [UIImage(), UIImage()] }
        
        guard let dataForFlatImage = try? Data(contentsOf: urlForFlat),
            let dataForShinyImage = try? Data(contentsOf: urlForShiny) else { return [UIImage(), UIImage()] }
        
        flatFlagImage = UIImage(data: dataForFlatImage)!
        shinyFlagImage =  UIImage(data: dataForShinyImage)!
        
        return [flatFlagImage, shinyFlagImage]
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

