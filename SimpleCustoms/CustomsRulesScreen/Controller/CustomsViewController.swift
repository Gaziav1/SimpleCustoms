//
//  CustomsViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 11/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import RealmSwift
import TinyConstraints

class CustomsViewController: UIViewController {
    
    var rules: CustomsRulesScreenModel! {
        didSet {
            flagImage.image = UIImage(named: rules.countryCode.lowercased())
    
            descriptionView.infoForCell = rules
        }
    }
 
    private var flagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let descriptionView: CountryDescriptionView = {
        let view = CountryDescriptionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rulesView: CustomsRulesView = {
        let view = CustomsRulesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let containterView = UIView()
    
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupScrollView()
        setupUIElementsInView()
    }

    override func viewDidLayoutSubviews() {
        scrollView.layoutIfNeeded()
        
        scrollView.contentSize.height = descriptionView.frame.height + rulesView.frame.height + flagImage.frame.height + 75
    }
    
    private func setupScrollView() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
    
        scrollView.edgesToSuperview()
    }
    
    private func setupRulesView() {
        containterView.addSubview(rulesView)
        rulesView.dataSource = self
        
        NSLayoutConstraint.activate([
            
            rulesView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 30),
            rulesView.leadingAnchor.constraint(equalTo: containterView.leadingAnchor,constant: 15),
            rulesView.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: -15),
            rulesView.heightAnchor.constraint(equalToConstant: view.frame.height)
            
        ])
    }
    
    private func setupNavigationController() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemBackground
        } else {
            view.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func setupUIElementsInView() {
        containterView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containterView)
        containterView.edgesToSuperview()
        containterView.centerInSuperview()

        setupImage()
        setupDescriptionView()
        setupRulesView()
    }
    
    private func setupImage() {
        containterView.addSubview(flagImage)
        
        flagImage.top(to: containterView.safeAreaLayoutGuide, offset: 8)
        flagImage.leading(to: containterView, offset: 18)
        flagImage.width(250)
        flagImage.height(170)
    
        flagImage.layer.cornerRadius = 10
        flagImage.layer.masksToBounds = true
    }
    
    private func setupDescriptionView() {
        containterView.addSubview(descriptionView)
        
        descriptionView.leading(to: containterView, offset: 25)
        descriptionView.topToBottom(of: flagImage, offset: 15)
        descriptionView.trailing(to: containterView, offset: -25)
        descriptionView.height(150)
    }
}
    
extension CustomsViewController: RulesCellDataSource {
    func defineContentForCell() -> List<CustomsRuleDescription> {
        return rules.customsRules
    }
}

