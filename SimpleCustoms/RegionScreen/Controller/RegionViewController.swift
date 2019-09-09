//
//  ViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 04/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class RegionViewController: UIViewController {
    
    @IBOutlet weak var unionsCollectionView: UICollectionView!
    private let regions = Regions.allCases
    private var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        unionsCollectionView.delegate = self
        unionsCollectionView.dataSource = self
    }
    
}

extension RegionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return regions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RegionCollectionViewCell
        cell.imageOfUnion.image = UIImage(named: "Europe")
        cell.nameOfUnion.text = regions[indexPath.row].rawValue
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NetworkManager.shared.createUrl(for: regions[indexPath.row])
        performSegue(withIdentifier: "showCountries", sender: self)
    }
}
