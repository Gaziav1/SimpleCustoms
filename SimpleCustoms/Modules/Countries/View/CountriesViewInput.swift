//
//  CountriesViewProtocol.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 31.01.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

protocol CountriesViewInput: class {

    var presenter: CountriesPresenterOutput!  { get set }
    
    func failure()
    func success()
    /* Presenter -> ViewController */
}
