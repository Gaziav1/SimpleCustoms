//
//  ImageHandler.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 29/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit




final class WebImageHandler {

    private init(){}
    
    static func prepareImages(countryCode: String) -> [UIImage?] {
  
        guard let urlForFlat = URL(string: "https://www.countryflags.io/\(countryCode)/flat/64.png"),
              let urlForShiny = URL(string: "https://www.countryflags.io/\(countryCode)/shiny/64.png") else { return [UIImage(named: "Europe"), nil] }
        
        do {
            let dataForFlatImage = try Data(contentsOf: urlForFlat)
            let dataForShinyImage = try Data(contentsOf: urlForShiny)
            guard let flatFlagImage = UIImage(data: dataForFlatImage), let shinyFlagImage =  UIImage(data: dataForShinyImage) else { return [UIImage(named: "Europe"), nil] }
            return [flatFlagImage, shinyFlagImage]
        
        } catch {
            print(error.localizedDescription)
            return [UIImage(named: "Europe"), nil]
        }
    }
}
