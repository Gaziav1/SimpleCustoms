//
//  SimpleCustomsTarget.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 03.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Moya


enum SimpleCustomsTarget {
    
    case currency(currency: String)
    case country(region: Regions)
    
}

extension SimpleCustomsTarget: TargetType {
    var baseURL: URL {
        switch self {
        case .currency:
            guard let url = URL(string: "https://api.ratesapi.io/") else { fatalError() }
            return url
        case .country:
            guard let url = URL(string: "https://restcountries.eu/") else { fatalError() }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .currency:
            return "api/latest"
        case let .country(region):
            return "rest/v2/region/\(region.rawValue.lowercased())"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .country:
            return nil
        case let .currency(currency):
            return ["base": currency,
                    "symbols": "RUB"]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return nil
    }
}
