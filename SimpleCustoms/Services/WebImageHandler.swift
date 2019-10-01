//
//  ImageHandler.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 29/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

enum ImageType: String {
    case flat
    case shiny
}


final class WebImageHandler {
    
    private init(){}
    private static let defaultImage = UIImage(named: "Europe")
    
    static func getImage(for countryCode: String, of type: ImageType) -> UIImage? {
        
        var image: UIImage?
        guard let urlForImage = URL(string: "https://www.countryflags.io/\(countryCode)/\(type.rawValue)/64.png") else { return UIImage(named: "Europe") }
        
        if let cachedImage = URLCache.shared.cachedResponse(for: URLRequest(url: urlForImage)) {
            image = UIImage(data: cachedImage.data)
            return image
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlForImage) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    image = UIImage(data: data)
                    self.handleLoadedImage(data: data, response: response)
                } else {
                    image = defaultImage
                }
            }
        }
        dataTask.resume()
        return image
    }
    
    private static func handleLoadedImage(data: Data, response: URLResponse ) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
