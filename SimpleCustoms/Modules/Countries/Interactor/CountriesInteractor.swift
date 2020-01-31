//
//  CountriesInteractor.swift
//  SimpleCustoms
//
//  Created Газияв Исхаков on 31.01.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CountriesInteractor {

    var networkManager: CountryFetcher
    weak var presenter: CountriesInteractorOutputProtocol?
    
    init(networkManager: CountryFetcher = NetworkCountryFetcher()) {
        self.networkManager = networkManager
    }
}
    
extension CountriesInteractor: CountriesInteractorInputProtocol {
    
    func fetchCountries() {
        networkManager.fetchCountries { [weak self] (countries, error) in
            guard let fetchedCountries = countries  else {
                self?.presenter?.obtainCountriesFailure()
                return
            }
            self?.presenter?.obtainCountriesSuccess(countries: fetchedCountries)
        }
    }
}
