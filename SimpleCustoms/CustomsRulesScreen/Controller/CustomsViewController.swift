//
//  CustomsViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 11/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import RealmSwift

class CustomsViewController: UIViewController {
    
    var rules = CustomsRules() {
        didSet {
            flagImage.image = UIImage(named: rules.forCountryCode?.lowercased() ?? "fr")
            rulesView.rules = rules.customsRule
        }
    }
    
    var flagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let countryDescription: UILabel = {
        let label = UILabel()
        label.text = "Канада славится своими практически нетронутыми природными ландшафтами, а также уникальной мозаичной культурой, составленной из самых разных традиций, привнесенных эмигрантами из всех уголков мира."
        
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        
        label.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupScrollView()
        setupUIElementsInView()
        setupNavigationController()
    }
    
    override func viewDidLayoutSubviews() {
 
    }
    
    private func setupScrollView() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
    
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    
    }
    
    private func setupRulesView() {
        containterView.addSubview(rulesView)
        
        NSLayoutConstraint.activate([
            
            rulesView.topAnchor.constraint(equalTo: countryDescription.bottomAnchor, constant: 30),
            rulesView.leadingAnchor.constraint(equalTo: containterView.leadingAnchor,constant: 15),
            rulesView.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: -15),
            rulesView.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
            
        ])
    }
    
    private func setupNavigationController() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemBackground
        } else {
            view.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        }
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func setupUIElementsInView() {
        containterView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containterView)
        
        containterView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containterView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containterView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containterView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containterView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        containterView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
        setupImage()
        setupDescriptionView()
        setupCountryDescription()
        setupRulesView()
    }
    
    private func setupImage() {
        containterView.addSubview(flagImage)
        
        NSLayoutConstraint.activate([
            
            flagImage.topAnchor.constraint(equalTo: containterView.safeAreaLayoutGuide.topAnchor, constant: 8),
            flagImage.leadingAnchor.constraint(equalTo: containterView.leadingAnchor, constant: 18),
            flagImage.widthAnchor.constraint(equalToConstant: 215),
            flagImage.heightAnchor.constraint(equalToConstant: 150)])
        
        flagImage.layer.cornerRadius = 20
        flagImage.layer.masksToBounds = true
    }
    
    private func setupDescriptionView() {
        containterView.addSubview(descriptionView)
        
        NSLayoutConstraint.activate([
            descriptionView.trailingAnchor.constraint(equalTo: containterView.safeAreaLayoutGuide.trailingAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: flagImage.safeAreaLayoutGuide.trailingAnchor),
            descriptionView.topAnchor.constraint(equalTo: containterView.safeAreaLayoutGuide.topAnchor, constant: 10),
            descriptionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupCountryDescription() {
        containterView.addSubview(countryDescription)
        NSLayoutConstraint.activate([
            countryDescription.topAnchor.constraint(equalTo: flagImage.bottomAnchor, constant: 30),
            countryDescription.leadingAnchor.constraint(equalTo: containterView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            countryDescription.trailingAnchor.constraint(equalTo: containterView.safeAreaLayoutGuide.trailingAnchor, constant: -20)])
    }
    
}


