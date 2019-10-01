//
//  FlagImage.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 07/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

final class FlagImage {
    
    var shinyflagImage: UIImage?
    var flatFlagImage: UIImage?
    
    
    init(countryCode: String) {
        
        
        self.flatFlagImage = NetworkManager.shared.fetchFlagsImages(for: countryCode, of: .flat)
        self.shinyflagImage = NetworkManager.shared.fetchFlagsImages(for: countryCode, of: .shiny)
    
    }
}


