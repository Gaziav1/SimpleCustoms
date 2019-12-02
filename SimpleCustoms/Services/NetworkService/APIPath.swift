//
//  APIPath.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 20.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation

protocol URLPath {
    var scheme: String { get }
    var endpoint: String { get }
    var path: String { get }
    var params: [String: String]? { get }
    
    var fullURL: URL? { get }
}

struct APIPath: URLPath {
    
    let scheme: String
    let endpoint: String
    let path: String
    let params: [String: String]?
    
    var fullURL: URL? {
        get {
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = endpoint
            urlComponents.path = path
            
            if let parameters = params {
                urlComponents.queryItems = parameters.map( { URLQueryItem(name: $0, value: $1)} )
            }
            guard let url = urlComponents.url else { return nil }
            return url
        }
    }
}

