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
    private var isErrorOcurred = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        handleDataDownloading()
    }
    
    
    private func setupTableView() {
        tableView.separatorColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func handleDataDownloading() {
        tableView.isHidden = true
        loadingAnimation.isHidden = false
        loadingAnimation.play()
        NetworkCountryFetcher.shared.fetchCountries { (country, error) in
            guard error == nil else {
                self.isErrorOcurred = true
                self.handleError()
                return
            }
            guard let countries = country else { return }
            self.countries = countries
            self.tableView.reloadData()
            self.loadingAnimation.stop()
            self.tableView.isHidden = false
            self.loadingAnimation.isHidden = true
        }
    }
    
    private func setupSearchController() {
        self.navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func handleError() {
        
        let image = UIImageView()
        image.image = UIImage(named: "sad2")
        image.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.5764705882, alpha: 1)
        label.text = "К сожалению загрузка данных не удалась. Пожалуйста, попытайтесь позднее."
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        let button = UIButton()
        button.setTitle("Обновить", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.5529411765, blue: 0.7803921569, alpha: 1)
        button.addTarget(self, action: #selector(handleDataDownloading), for: .touchUpInside)
        
        if !isErrorOcurred {
            should(hide: true, elements: [button, label, image])
        } else {
            should(hide: false, elements: [button, label, image])
        }
        
        view.addSubview(image)
        view.addSubview(label)
        view.addSubview(button)
        image.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 25),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 25),
            button.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 300),
            button.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
        button.layer.cornerRadius = 25
    }
    
    private func should(hide: Bool, elements: [UIView]) {
        elements.forEach({ $0.isHidden = hide })
    }
    
    @objc private func buttonAction() {
        handleDataDownloading()
        isErrorOcurred = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showCustomsRules" else { return }
        let segue = segue.destination as! CustomsViewController
        let country: Country
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        if isSearching {
            country = searchResults[indexPath.row]
        } else {
            country = countries[indexPath.row]
        }
        let title = country
        let customsRule = RealmManager.sharedInstance.filter(NSPredicate(format: "forCountryCode == %@", title.alpha2Code)) //запрашиваем информацию о таможенных правилах страны по ее коду
        guard let data = country.flagImages?.flatFlagImage, let image = UIImage(data: data) else { return }
        segue.imageFlag.image = image
        segue.rules = customsRule[0]
        segue.navigationItem.title = title.name
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
        let country: Country
        if isSearching {
            country = searchResults[indexPath.row]
            
        } else {
            country = countries[indexPath.row]
            
        }
    
        cell.countryName.text = country.name
        guard let data = country.flagImages?.flatFlagImage, let image = UIImage(data: data) else { return cell }
        cell.countryFlag.image = image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainScreenTableViewCell
        let country = countries[indexPath.row]
        guard let data = country.flagImages?.shinyFlagImage, let image = UIImage(data: data) else { return }
        cell.countryFlag.image = image
        cell.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainScreenTableViewCell
        let country = countries[indexPath.row]
        guard let data = country.flagImages?.flatFlagImage, let image = UIImage(data: data) else { return }
        cell.countryFlag.image = image
        cell.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1764705882, blue: 0.231372549, alpha: 1)
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
