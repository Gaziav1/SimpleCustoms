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
                let allowedCharacterSet = CharacterSet.urlQueryAllowed
                let encodedParams = parameters.mapValues({ $0.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) })
                urlComponents.queryItems = encodedParams.map( { URLQueryItem(name: $0, value: $1)} )
            }
            guard let url = urlComponents.url else { return nil }
            
            return url
        }
    }
}

enum FullUrl: CaseIterable {
    case asia
    case europe
    
    var fullUrlForCountries: URL? {
        get {
            switch self {
            case .asia:
                let path = APIPath(scheme: "https", endpoint: "restcountries.eu", path: "/rest/v2/region/asia", params: nil)
                guard let url = path.fullURL else { return nil }
                return url
            case .europe:
                let path = APIPath(scheme: "https", endpoint: "restcountries.eu", path: "/rest/v2/region/europe", params: nil)
                guard let url = path.fullURL else { return nil }
                return url
            }
        }
    }
}

