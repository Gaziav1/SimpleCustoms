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
    
    private var countries = [Country]()
    private var flagImages = [FlagImage]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.separatorColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        handleError()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
        handleDataDownloading()
    }
    
    @objc private func handleDataDownloading() {
        tableView.isHidden = true
        loadingAnimation.isHidden = false
        loadingAnimation.play()
        NetworkCountryFetcher.shared.fetchCountries { (country, flagImage, error) in
            guard error == nil else {
                return
            }
            guard let countries = country, let flagImages = flagImage else {  return }
            self.countries = countries
            self.flagImages = flagImages
            self.tableView.reloadData()
            self.loadingAnimation.stop()
            self.tableView.isHidden = false
            self.loadingAnimation.isHidden = true
        }
    }
    
    @objc private func buttonAction() {
        handleDataDownloading()
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
        
        button.layer.cornerRadius = 15
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showCustomsRules" else { return }
        let segue = segue.destination as! CustomsViewController
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        let title = countries[indexPath.row]
        let image = flagImages[indexPath.row].flatFlagImage
        
        let customsRule = RealmManager.sharedInstance.filter(NSPredicate(format: "forCountryCode == %@", title.alpha2Code))
        
        segue.rules = customsRule[0]
        segue.imageFlag.image = image
        segue.navigationItem.title = title.name
        
    }
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainScreenTableViewCell
        cell.countryFlag.image = flagImages[indexPath.row].flatFlagImage
        cell.countryName.text = countries[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainScreenTableViewCell
        cell.countryFlag.image = flagImages[indexPath.row].shinyflagImage
        cell.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainScreenTableViewCell
        cell.countryFlag.image = flagImages[indexPath.row].flatFlagImage
        cell.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1764705882, blue: 0.231372549, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCustomsRules", sender: self)
    }
}




