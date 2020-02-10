//
//  AppRouter.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 05.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import UIKit
import Swinject

enum RouterDestination {
    case countries
    case customs(rules: CustomsRules)
    
    func constructModule(in factory: Container) -> UIViewController? {
        switch self {
        case .countries:
            return factory.resolve(UIViewController.self, name: CountriesConfigurator.tag)
        case let .customs(rules):
            return factory.resolve(UIViewController.self, name: CustomsConfigurator.tag, argument: rules)
        }
    }
}

protocol AppRouterProtocol {
    
    func createModule(for destination: RouterDestination) -> UIViewController
    func performTransition(to destination: RouterDestination)
    func initialViewController() -> UINavigationController
    
}

class AppRouter: AppRouterProtocol {
    static let shared: AppRouter = AppRouter()
    let container: Container
    var initialController: UINavigationController
    
    init(container: Container = Containers.viewControllers.container,
         initialController: UINavigationController = UINavigationController()) {
        self.container = container
        self.initialController = initialController
    }
    
    func createModule(for destination: RouterDestination) -> UIViewController {
        guard let target = destination.constructModule(in: container) else { fatalError() }
        return target
    }
    
    func performTransition(to destination: RouterDestination) {
        let target = createModule(for: destination)
        initialController.pushViewController(target, animated: true)
    }
    
    func initialViewController() -> UINavigationController {
        let viewController = createModule(for: .countries)
        initialController.viewControllers = [viewController]
        return initialController
    }
}
