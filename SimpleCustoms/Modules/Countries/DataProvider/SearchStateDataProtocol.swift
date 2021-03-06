//
//  SearchStateDataProtocol.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 31.01.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

protocol SearchStateDataProtocol {
    var currentData: [Country] { get }
    
    func setRegion(region: Regions)
    func startSearching(_ searchText: String)
    func stopSearching()
    func setCountries(countries: [Country])
}
