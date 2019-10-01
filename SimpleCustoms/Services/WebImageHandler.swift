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
    
    static func getImage(for countryCode: String, of type: ImageType) -> Data? {
        
        guard let urlForImage = URL(string: "https://www.countryflags.io/\(countryCode)/\(type.rawValue)/64.png") else { return nil }
        var dataForImage: Data?
        
        if let cachedImage = URLCache.shared.cachedResponse(for: URLRequest(url: urlForImage)) {
            return cachedImage.data
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlForImage) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    dataForImage = data
                    self.handleLoadedImage(data: data, response: response)
                } else {
                    dataForImage = nil
                }
            }
        }
        dataTask.resume()
        return dataForImage
    }
    
    private static func handleLoadedImage(data: Data, response: URLResponse ) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
