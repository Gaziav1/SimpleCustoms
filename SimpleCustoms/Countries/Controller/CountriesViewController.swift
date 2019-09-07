//
//  CountriesViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 05/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit


class CountriesViewController: UIViewController {
    
    @IBOutlet weak var countriesCollectionView: UICollectionView!
    private var countries = [Country]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getCountries { (countries) in
            self.countries = countries
            self.countriesCollectionView.reloadData()
        }
    
        countriesCollectionView.dataSource = self
        countriesCollectionView.delegate = self
    }
}

extension CountriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! CountriesCollectionViewCell
        
        guard let flagImage = FlagImage(countryCode: countries[indexPath.row].alpha2Code) else { return cell}
        cell.countryFlagImage.image = flagImage.flagImage
        cell.countryNameLabel.text = countries[indexPath.row].name
        return cell
    }
    

    
}
