//
//  ViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 04/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import Lottie

class CountryViewController: UIViewController {
    
    private let countriesTableView: UITableView = {
        let tableView = UITableView()
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
        let animation = Animation.named("1055-world-locations")
        var load = AnimationView()
        load.animation = animation
        load.animationSpeed = 1
        load.loopMode = .loop
        load.contentMode = .scaleAspectFit
        
        return load
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchResults = [Country]()
    private var isSearching = false
    
    private var countries = [Country]()
    
    private var errorHandler = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDataDownloading()
        setupErrorView()
        setupTableView()
        setupSearchController()
    }
    
    private func setupTableView() {
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        view.addSubview(countriesTableView)
        
        NSLayoutConstraint.activate([
            countriesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            countriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupErrorView() {
        errorHandler.translatesAutoresizingMaskIntoConstraints = false
        errorHandler.isHidden = true
        errorHandler.buttonForError.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(errorHandler)
        
        NSLayoutConstraint.activate([
            errorHandler.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorHandler.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorHandler.widthAnchor.constraint(equalTo: view.widthAnchor),
            errorHandler.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0.5)
        ])
    }
    
    private func handleDataDownloading() {
        //Метод проигрывает анимацию пока идет загрузка данных, в случае ошибки выводит UI элементы с кнопкой, по тапу на которую метод вызывается снова
        countriesTableView.isHidden = true
        loadingAnimation.fadeIn()
        loadingAnimation.play()
        NetworkCountryFetcher.shared.fetchCountries { (country, error) in
            guard error == nil else {
                self.loadingAnimation.isHidden = true
                self.errorHandler.fadeIn()
                return
            }
            guard let countries = country else { return }
            self.countries = countries
            self.loadingAnimation.stop()
            self.countriesTableView.fadeIn()
            self.loadingAnimation.fadeOut()
            self.countriesTableView.reloadData()
        }
    }
    
    private func setupSearchController() {
        self.navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    @objc private func buttonAction() {
        errorHandler.fadeOut()
        handleDataDownloading()
    }
    
    private func searchState(indexPath: IndexPath) -> Country {
        let country: Country
        if isSearching {
            country = searchResults[indexPath.row]
        } else {
            country = countries[indexPath.row]
        }
        return country
    }
    
    private func checkImage(country: Country, imageType: ImageType) -> UIImage {
        switch imageType  {
        case .flat:
            guard let data = country.flagImages?.flatFlagImage, let image = UIImage(data: data) else { return UIImage() }
            return image
        case .shiny:
            guard let data = country.flagImages?.shinyFlagImage, let image = UIImage(data: data) else { return UIImage() }
            return image
        }
    }
    
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchResults.count
        } else {
            return countries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseId) as! CountryTableViewCell
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let country = searchState(indexPath: indexPath)
        cell.countryName.text = country.name
        cell.flagImage.image = checkImage(country: country, imageType: .flat)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryTableViewCell
        let country = searchState(indexPath: indexPath)
        cell.flagImage.image = checkImage(country: country, imageType: .shiny)
        
        if #available(iOS 13.0, *) {
            cell.countryView.backgroundColor = .systemIndigo
        } else {
            cell.countryName.textColor = .white
            cell.countryView.backgroundColor = #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryTableViewCell
        let country = searchState(indexPath: indexPath)
        cell.flagImage.image = checkImage(country: country, imageType: .flat)
        
             if #available(iOS 13.0, *) {
                cell.countryView.backgroundColor = .tertiarySystemBackground
           } else {
                cell.countryName.textColor = .black
                cell.countryView.backgroundColor = .white
           }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CustomsViewController()
        navigationController?.dismiss(animated: true, completion: nil)
        
        let country = searchState(indexPath: indexPath)
        
        let customsRule = RealmManager.sharedInstance.filter(NSPredicate(format: "forCountryCode == %@", country.alpha2Code), object: CustomsRules.self) as! [CustomsRules] //запрашиваем информацию о таможенных правилах страны по ее коду
        vc.rules = customsRule[0]
        vc.navigationItem.title = country.name
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension CountryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = countries.filter({$0.name.prefix(searchText.count) == searchText})
        searchController.searchBar.showsCancelButton = true
        isSearching = true
        countriesTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchController.searchBar.showsCancelButton = false
        countriesTableView.reloadData()
    }
}
