//
//  ViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 04/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class UnionViewController: UIViewController {

    @IBOutlet weak var unionsCollectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        unionsCollectionView.delegate = self
        unionsCollectionView.dataSource = self
    }
    

}

extension UnionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UnionCollectionViewCell
        
        return cell
    }
    
    
}

