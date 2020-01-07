//
//  DataHandler.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 28.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation

class DataProvider {
    
    fileprivate var countries = [Country]()
    fileprivate var countriesCopy = [Country]()
    
    var currentData: [Country] {
        return countries
    }
    
    var currentRegion: Regions = .all {
        didSet {
            startSearching(searchText)
        }
    }
    fileprivate var searchText = ""
    
    func startSearching(_ searchText: String) {
        self.searchText = searchText
        let currentDataArray = countiresForCurrentRegion()
        
        if searchText == "" {
            countries = currentDataArray
        } else {
            countries = currentDataArray.filter({ $0.name.contains(searchText) })
        }
    }
    
    func stopSearching() {
        searchText = ""
        if currentRegion == .all {
            countries = countriesCopy
        } else {
            countries = countriesCopy.filter({ $0.region == currentRegion.rawValue })
        }
    }
    
    func setCountries(_ country: [Country]) {
        countries = country
        countriesCopy = country
    }
    
    private func countiresForCurrentRegion() -> [Country] {
        
        var arrayCopy = countriesCopy
        
        switch currentRegion  {
        case .all:
            arrayCopy = countriesCopy
        case .europe:
            arrayCopy = countriesCopy.filter({ $0.region == "Europe" })
        case .asia:
            arrayCopy = countriesCopy.filter({ $0.region == "Asia" })
        }
        
        return arrayCopy
    }
}

