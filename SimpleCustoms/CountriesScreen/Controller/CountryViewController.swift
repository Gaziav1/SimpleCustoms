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
    @IBOutlet weak var loadingAnimation: AnimationView! 
    
    private var countries = [Country]()
    private var flagImages = [FlagImage]()
    private var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        handleDataDownloading()
    }
    

    
    private func handleDataDownloading() {
        tableView.isHidden = true
        tableView.separatorColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let animation = Animation.named("1055-world-locations")
        loadingAnimation.animation = animation
        loadingAnimation.animationSpeed = 1
        loadingAnimation.loopMode = .loop
        loadingAnimation.contentMode = .scaleAspectFit
        loadingAnimation.play()
        NetworkCountryFetcher.shared.fetchCountries { (country, flagImage) in
            self.countries = country
            self.flagImages = flagImage
            self.tableView.reloadData()
            self.loadingAnimation.stop()
            self.tableView.isHidden = false
            self.loadingAnimation.isHidden = true
        }
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

    


