//
//  CountriesConfigurator.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 06.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import UIKit


class CountriesConfigurator {
    
    static let tag = "CountriesConfigurator"
    
    func createModule() -> UIViewController {
           // Change to get view from storyboard if not using progammatic UI
           let view = CountriesViewController(nibName: nil, bundle: nil)
           let interactor = CountriesInteractor()
           let router = CountriesRouter()
           let presenter = CountriesPresenter(interface: view, interactor: interactor, router: router)

           view.presenter = presenter
           interactor.presenter = presenter
           
           return view
       }
    
}
