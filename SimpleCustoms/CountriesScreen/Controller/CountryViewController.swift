//
//  ViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 04/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import Lottie
import TinyConstraints
import RealmSwift

protocol CountryChooseDelegate: class {
    func didChooseCountry(_ name: String, code: String, imageData: Data)
}

class CountryViewController: UIViewController {
    
    private let countriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: CountryTableViewCell.reuseId)
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .secondarySystemBackground
        } else {
            tableView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        }
        return tableView
    }()
    
    private let loadingAnimation: AnimationView = {
        let animation = Animation.named("3003-bouncy-balls")
        var load = AnimationView()
        load.animation = animation
        load.animationSpeed = 1
        load.loopMode = .loop
        load.contentMode = .scaleAspectFit
        load.translatesAutoresizingMaskIntoConstraints = false
        return load
    }()
    
    private var networkManager: CountryFetcher?
    private let searchController = UISearchController(searchResultsController: nil)
    private let regionChooser = RegionView()
    private let dataHandler = DataProvider()
    private let errorHandler = ErrorView()
    
    weak var delegate: CountryChooseDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager = NetworkCountryFetcher()
    
        if #available(iOS 13.0, *) {
            navigationController?.view.backgroundColor = .tertiarySystemBackground
        } else {
            view.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        }

        self.navigationItem.largeTitleDisplayMode = .never
        handleDataDownloading()
        setupSearchController()
        setupTableView()
        setupRegionChooser()
        setupAnimation()
        setupErrorView()
    }
    
    
    private func setupRegionChooser() {
        regionChooser.translatesAutoresizingMaskIntoConstraints = false
        regionChooser.delegate = self
        view.addSubview(regionChooser)
        
        regionChooser.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        regionChooser.height(46)
    }
    
    private func setupAnimation() {
        view.addSubview(loadingAnimation)
        loadingAnimation.center(in: view)
        loadingAnimation.height(75)
        loadingAnimation.width(75)
    }
    
    private func setupTableView() {
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        view.addSubview(countriesTableView)
        
        countriesTableView.top(to: view.safeAreaLayoutGuide, offset: 45)
        countriesTableView.edgesToSuperview(excluding: .top)
        
    }
    
    private func setupErrorView() {
        errorHandler.translatesAutoresizingMaskIntoConstraints = false
        errorHandler.isHidden = true
        view.addSubview(errorHandler)
        errorHandler.top(to: view.safeAreaLayoutGuide, offset: 55)
        errorHandler.centerX(to: view)
        errorHandler.widthToSuperview()
        errorHandler.heightToSuperview(view.heightAnchor, multiplier: 0.5)
        
        errorHandler.buttonForError.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    private func handleDataDownloading() {
        
        loadingAnimation.isHidden = false
        loadingAnimation.play()
        networkManager?.fetchCountries { (country, error) in
            guard error == nil else {
                self.loadingAnimation.isHidden = true
                self.errorHandler.fadeIn()
                return
            }
            guard let countries = country else { return }
            self.dataHandler.setCountries(countries)
            self.loadingAnimation.stop()
            self.countriesTableView.fadeIn()
            self.loadingAnimation.isHidden = true
            self.countriesTableView.reloadData()
        }
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Искать страну"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    @objc private func buttonAction() {
        errorHandler.fadeOut()
        handleDataDownloading()
    }
    
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataHandler.currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseId) as! CountryTableViewCell
        let cellInfo = CountryScreenModel(country: dataHandler.currentData[indexPath.row])
        
        cell.fillCell(with: cellInfo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryTableViewCell
        
        UIView.animate(withDuration: 0.2) {
            let scale: CGFloat = 0.9
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryTableViewCell
        
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CustomsViewController()
        navigationController?.dismiss(animated: true, completion: nil)
        
        let country = CountryScreenModel(country: dataHandler.currentData[indexPath.row])
        let predicate = NSPredicate(format: "forCountryCode == %@", country.countryName)
        
        let countryInformation = RealmManager.sharedInstance.filter(predicate, object: CustomsRules.self) as! [CustomsRules] //запрашиваем информацию о таможенных правилах страны по ее названию
        
        let customsRules = CustomsRulesScreenModel(country: country, rules: countryInformation[0].customsRule)
        
        vc.rules = customsRules
        vc.navigationItem.title = country.countryName
        navigationController?.pushViewController(vc, animated: true)
        
        delegate?.didChooseCountry(country.countryName, code: country.countryCode, imageData: Data())
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension CountryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataHandler.startSearching(searchText)
        
        countriesTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataHandler.stopSearching()
        searchController.searchBar.showsCancelButton = false
        countriesTableView.reloadData()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchController.searchBar.showsCancelButton = true
        return true
    }
}

extension CountryViewController: RegionChooseDelegate {
    
    func userDidChooseRegion(_ region: Regions) {
        dataHandler.currentRegion = region
        countriesTableView.reloadData()
    }
    
}
