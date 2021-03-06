//
//  CustomsPresenter.swift
//  SimpleCustoms
//
//  Created Газияв Исхаков on 05.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CustomsPresenter: CustomsPresenterProtocol, CustomsInteractorOutputProtocol {

    weak private var view: CustomsViewProtocol?
    var interactor: CustomsInteractorInputProtocol?
    private let router: CustomsWireframeProtocol

    init(interface: CustomsViewProtocol, interactor: CustomsInteractorInputProtocol?, router: CustomsWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
