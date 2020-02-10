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
import Realm
import Moya

class CountriesInteractor {
    
    var provider = MoyaProvider<SimpleCustomsTarget>()
    weak var presenter: CountriesInteractorOutputProtocol?
}

extension CountriesInteractor: CountriesInteractorInputProtocol {
    func rulesForCountry(country: Country) {
        
        let predicate = NSPredicate(format: "forCountryCode == %@", country.alpha2Code)
        
        guard let countryInformation = RealmManager.sharedInstance.filter(predicate, object: CustomsRules.self) else { return }
        
        presenter?.didGetCustomsRules(rules: countryInformation[0])
    }
    
    func fetchCountries(for regions: [Regions]) {
        for region in regions {
            provider.request(.country(region: region)) { [weak self] (result) in

                switch result {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode([Country].self, from: response.data) else { return }
                    
                    self?.presenter?.obtainCountriesSuccess(countries: data)
                case .failure(_):
                    self?.presenter?.obtainCountriesFailure()
                }
            }
        }
    }
    
}

