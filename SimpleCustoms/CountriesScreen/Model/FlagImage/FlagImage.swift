//
//  FlagImage.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 07/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class FlagImage: Decodable {
    
    var flatFlagImage: Data?
   
    init(countryCode: String) {
    
        NetworkCountryFetcher.shared.fetchFlagsImages(for: countryCode, completion: { self.flatFlagImage = $0 })
    }
}


