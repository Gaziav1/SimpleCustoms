//
//  ViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 04/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import Lottie

class RegionViewController: UIViewController {
    
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
        tableView.separatorColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 0.6863377109)
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
    
}

extension RegionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainScreenTableViewCell
        cell.countryFlag.image = flagImages[indexPath.row].flatFlagImage
        cell.countryName.text = countries[indexPath.row].name
        tableView.deselectRow(at: indexPath, animated: true)
        cell.selectionStyle = .default
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainScreenTableViewCell
        cell.countryFlag.image = flagImages[indexPath.row].shinyflagImage
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

    


