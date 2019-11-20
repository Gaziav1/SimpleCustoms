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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingAnimation: AnimationView! {
        didSet {
            let animation = Animation.named("1055-world-locations")
            loadingAnimation.animation = animation
            loadingAnimation.animationSpeed = 1
            loadingAnimation.loopMode = .loop
            loadingAnimation.contentMode = .scaleAspectFit
        }
    }
    
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
        tableView.separatorColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupErrorView() {
        errorHandler.translatesAutoresizingMaskIntoConstraints = false
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
        tableView.isHidden = true
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
            self.tableView.fadeIn()
            self.loadingAnimation.fadeOut()
            self.tableView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showCustomsRules" else { return }
        let segue = segue.destination as! CustomsViewController
        navigationController?.dismiss(animated: true, completion: nil)
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        
        let country = searchState(indexPath: indexPath)
        
        let customsRule = RealmManager.sharedInstance.filter(NSPredicate(format: "forCountryCode == %@", country.alpha2Code), object: CustomsRules.self) as! [CustomsRules] //запрашиваем информацию о таможенных правилах страны по ее коду
        segue.imageFlag.image = checkImage(country: country, imageType: .flat)
        segue.rules = customsRule[0]
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainScreenTableViewCell
        cell.selectionStyle = .none
        let country = searchState(indexPath: indexPath)
        cell.countryName.text = country.name
        cell.countryFlag.image = checkImage(country: country, imageType: .flat)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainScreenTableViewCell
        let country = searchState(indexPath: indexPath)
        cell.countryFlag.image = checkImage(country: country, imageType: .shiny)
        cell.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainScreenTableViewCell
        let country = searchState(indexPath: indexPath)
        cell.countryFlag.image = checkImage(country: country, imageType: .flat)
        cell.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCustomsRules", sender: self)
    }
}

extension CountryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = countries.filter({$0.name.prefix(searchText.count) == searchText})
        searchController.searchBar.showsCancelButton = true
        isSearching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchController.searchBar.showsCancelButton = false
        tableView.reloadData()
    }
}
