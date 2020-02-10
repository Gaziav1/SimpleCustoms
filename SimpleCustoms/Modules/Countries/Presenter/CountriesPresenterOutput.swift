//
//  CountriesPresenterOutput.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 31.01.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import UIKit

protocol CountriesPresenterOutput: class {

    var interactor: CountriesInteractorInputProtocol? { get set }
    
    var searchStateDataProvider: SearchStateDataProtocol { get }
    
    var countriesCount: Int { get }
    
    func country(atIndexPath indexPath: IndexPath) -> Country
    func searchStarted(with searchText: String)
    func stopSearching()
    func setCurrentRegion(_ region: Regions)
    func fetchCountries()
    func didSelectCountry(atIndexPath indexPath: IndexPath)
}
