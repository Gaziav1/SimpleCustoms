//
//  FlagImage.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 07/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class FlagImage: Decodable {
    
    var shinyFlagImage: Data?
    var flatFlagImage: Data?
    
    
    init(countryCode: String) {
        
        NetworkCountryFetcher.shared.fetchFlagsImages(for: countryCode, of: .flat, completion: { self.flatFlagImage = $0 })
        NetworkCountryFetcher.shared.fetchFlagsImages(for: countryCode, of: .shiny, completion: { self.shinyFlagImage = $0 })
    }
}


