//
//  FlagImage.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 07/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

final class FlagImage {
    
    var flagImage: UIImage?
    
    
    
    init?(countryCode: String) {
        
        DispatchQueue.global().sync {
            self.flagImage = NetworkManager.shared.fetchFlagsImages(for: countryCode) ?? UIImage(named: "Europe")
        }
    }
}


