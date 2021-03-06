//
//  CustomsProtocols.swift
//  SimpleCustoms
//
//  Created Газияв Исхаков on 05.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol CustomsWireframeProtocol: class {

}
//MARK: Presenter -
protocol CustomsPresenterProtocol: class {

    var interactor: CustomsInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol CustomsInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol CustomsInteractorInputProtocol: class {

    var presenter: CustomsInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol CustomsViewProtocol: class {

    var presenter: CustomsPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
