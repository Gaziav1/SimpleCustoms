//
//  CountriesViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 05/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

//import UIKit
//import Lottie
//
//
//class CountriesViewController: UIViewController {
//    
//    @IBOutlet weak var progressAnimation: AnimationView! {
//        didSet {
//            let progress = Animation.named("6056-gradient-loader")
//            progressAnimation.contentMode = .scaleAspectFit
//            progressAnimation.animation = progress
//            progressAnimation.loopMode = .autoReverse
//            
//        }
//    }
//    @IBOutlet weak var countriesCollectionView: UICollectionView!
//    private var countries = [Country]()
//    private var flagImage = [FlagImage]()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        progressAnimation.play()
//        NetworkCountryFetcher.shared.fetchCountries(completionHandler: { [unowned self] (countries, flagImages) in
//            self.countries = countries
//            self.flagImage = flagImages
//            self.countriesCollectionView.reloadData()
//            self.progressAnimation.stop()
//        })
//      
//
//        
//        countriesCollectionView.dataSource = self
//        countriesCollectionView.delegate = self
//    }
//}
//
//extension CountriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return countries.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! CountriesCollectionViewCell
//        
//        cell.layer.cornerRadius = cell.frame.width / 4
//        cell.selectedBackgroundView?.backgroundColor = .cyan
//        cell.countryFlagImage.image = flagImage[indexPath.row].flagImage
//        cell.countryNameLabel.text = countries[indexPath.row].name
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! CountriesCollectionViewCell
//        cell.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
//        cell.countryNameLabel.textColor = .white
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! CountriesCollectionViewCell
//        cell.backgroundColor = collectionView.backgroundColor
//        cell.countryNameLabel.textColor = .black
//    }
//}
