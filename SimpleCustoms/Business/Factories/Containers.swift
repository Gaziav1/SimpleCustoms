//
//  Containers.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 06.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Swinject

enum Containers {
    
    case viewControllers
    case managers
    
    var container: Container {
        switch self {
        case .viewControllers:
            return type(of: self).viewControllersContainer
        case .managers:
            return type(of: self).managersContainer
        }
    }
    
    
    private static let viewControllersContainer: Container = {
        let container = Container()
        
        container.register(UIViewController.self, name: CountriesConfigurator.tag) { (_) in
            let countriesConfigurator = CountriesConfigurator()
            let viewController = countriesConfigurator.createModule()
            return viewController
        }
        
        container.register(UIViewController.self, name: CustomsConfigurator.tag) { (_, data: CustomsRules) in
            let customsConfigurator = CustomsConfigurator(data: data)
            let viewController = customsConfigurator.createModule()
            return viewController
        }
        
        return container
    }()
    
    private static let managersContainer: Container = {
        let container = Container()
        
        container.register(AppRouter.self) { (resolver) in
            let router = AppRouter()
            return router
        }
        
        return container
    }()
}
