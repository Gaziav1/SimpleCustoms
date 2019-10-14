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
    
    private var buttonForError: UIButton = {
        let button = UIButton()
        button.setTitle("Обновить", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.5529411765, blue: 0.7803921569, alpha: 1)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var labelForError: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.5764705882, alpha: 1)
        label.isHidden = true
        label.text = "К сожалению загрузка данных не удалась. Пожалуйста, попытайтесь позднее."
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var imageForError: UIImageView = {
        let image = UIImageView()
        image.isHidden = true
        image.image = UIImage(named: "sad2")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIElementsForError()
        handleDataDownloading()
        setupTableView()
        setupSearchController()
    }
    
    private func setupTableView() {
        tableView.separatorColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func handleDataDownloading() {
        //Метод проигрывает анимацию пока идет загрузка данных, в случае ошибки выводит UI элементы с кнопкой, по тапу на которую метод вызывается снова
        tableView.isHidden = true
        loadingAnimation.fadeIn()
        loadingAnimation.play()
        NetworkCountryFetcher.shared.fetchCountries { (country, error) in
            guard error == nil else {
                self.loadingAnimation.isHidden = true
                self.should(hide: false, elements: [self.imageForError, self.buttonForError, self.labelForError])
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
    
    private func setupUIElementsForError() {
        view.addSubview(imageForError)
        view.addSubview(labelForError)
        view.addSubview(buttonForError)
        
        buttonForError.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            imageForError.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            imageForError.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelForError.topAnchor.constraint(equalTo: imageForError.bottomAnchor, constant: 25),
            labelForError.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            labelForError.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            buttonForError.topAnchor.constraint(equalTo: labelForError.bottomAnchor, constant: 25),
            buttonForError.centerXAnchor.constraint(equalTo: imageForError.centerXAnchor),
            buttonForError.widthAnchor.constraint(equalToConstant: 300),
            buttonForError.heightAnchor.constraint(equalToConstant: 40)
        ])
        buttonForError.layer.cornerRadius = 15
    }
    
    private func should(hide: Bool, elements: [UIView]) {
        guard !hide else {
            elements.forEach({ $0.isHidden = true })
            return
        }
        elements.forEach({ $0.fadeIn() })
    }
    
    @objc private func buttonAction() {
        should(hide: true, elements: [buttonForError, imageForError, labelForError])
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
