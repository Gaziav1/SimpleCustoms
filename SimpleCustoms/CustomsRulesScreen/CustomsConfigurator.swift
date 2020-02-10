//
//  CustomsConfigurator.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 06.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//


import UIKit
import Realm

class CustomsConfigurator {
    
    static let tag = "CustomsConfigurator"
    
    private let data: CustomsRules
    
    init(data: CustomsRules) {
        self.data = data
    }
    
    func createModule() -> UIViewController {
           // Change to get view from storyboard if not using progammatic UI
           let view = CustomsViewController(nibName: nil, bundle: nil)
           let interactor = CustomsInteractor()
           let router = CustomsRouter()
           let presenter = CustomsPresenter(interface: view, interactor: interactor, router: router)

           view.presenter = presenter
           interactor.presenter = presenter
           view.rules = data
           return view
       }
}
