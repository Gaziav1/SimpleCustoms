//
//  FlagImage.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 07/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

struct FlagImage: Decodable {
    
    var shinyFlagImage: Data?
    var flatFlagImage: Data?
    
    
    init(countryCode: String) {
        
        self.flatFlagImage = NetworkCountryFetcher.shared.fetchFlagsImages(for: countryCode, of: .flat)
        self.shinyFlagImage = NetworkCountryFetcher.shared.fetchFlagsImages(for: countryCode, of: .shiny)
    
    }
}


