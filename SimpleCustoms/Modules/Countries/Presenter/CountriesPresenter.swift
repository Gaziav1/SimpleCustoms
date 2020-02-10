//
//  CountriesPresenter.swift
//  SimpleCustoms
//
//  Created Газияв Исхаков on 31.01.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CountriesPresenter {
    
    weak private var view: CountriesViewInput?
    var interactor: CountriesInteractorInputProtocol?
    let searchStateDataProvider: SearchStateDataProtocol
    private let router: CountriesRouterInput
    
    var countriesCount: Int {
        return searchStateDataProvider.currentData.count
    }
    
    init(interface: CountriesViewInput,
         interactor: CountriesInteractorInputProtocol?,
         router: CountriesRouterInput,
         searchDataProvider: SearchStateDataProtocol = SearchStateDataProvider()) {
        
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.searchStateDataProvider = searchDataProvider
    }
}

extension CountriesPresenter: CountriesInteractorOutputProtocol {
    
    func didGetCustomsRules(rules: CustomsRules) {
        router.performTransitionToCustoms(data: rules)
    }
    
    func obtainCountriesSuccess(countries: [Country]?) {
        guard countries != nil else {
            view?.failure()
            return
        }
        searchStateDataProvider.setCountries(countries: countries!)
        view?.success()
    }
    
    func obtainCountriesFailure() {
        view?.failure()
    }
}

extension CountriesPresenter: CountriesPresenterOutput {
    func fetchCountries() {
        interactor?.fetchCountries(for: [.europe, .asia])
    }
    
    func setCurrentRegion(_ region: Regions) {
        searchStateDataProvider.setRegion(region: region)
    }
    
    func stopSearching() {
        searchStateDataProvider.stopSearching()
    }
    
    func searchStarted(with searchText: String) {
        searchStateDataProvider.startSearching(searchText)
    }
    
    func country(atIndexPath indexPath: IndexPath) -> Country {
        return searchStateDataProvider.currentData[indexPath.row]
    }
    
    func didSelectCountry(atIndexPath indexPath: IndexPath) {
        let choosenCountry = country(atIndexPath: indexPath)
        interactor?.rulesForCountry(country: choosenCountry)
        
        //
                 
        //
        //        let customsRules = CustomsRulesScreenModel(country: country, rules: countryInformation[0].customsRule)
        //
        //        vc.rules = customsRules
        //        vc.navigationItem.title = country.countryName
        //        navigationController?.pushViewController(vc, animated: true)
        //
        //        delegate?.didChooseCountry(country.countryName, code: country.countryCode, imageData: country.imageData)

    }
}
