//
//  RegionView.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 26.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import TinyConstraints

protocol RegionChooseDelegate: class {
    func userDidChooseRegion(_ region: Regions)
}

class RegionView: UIView {
    
    private let regionCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(RegionCollectionViewCell.self, forCellWithReuseIdentifier: RegionCollectionViewCell.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .tertiarySystemBackground
        } else {
            collectionView.backgroundColor = .white
        }
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    weak var delegate: RegionChooseDelegate?
    
    private var regions: [Regions] = [.all, .europe, .asia]
    private var alignment: CGFloat = 1/3
    private var horizontalBarAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .tertiarySystemBackground
        } else {
            backgroundColor = .white
        }
        setupCollectionView()
        setupSelectionBar()
        dropShadow(scale: true, shadowOffset: CGSize(width: 0, height: 3), opacity: 0.15, radius: 2)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        regionCollection.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupCollectionView() {
        addSubview(regionCollection)
        regionCollection.delegate = self
        regionCollection.dataSource = self
        regionCollection.register(UINib(nibName: "RulesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RulesCollectionViewCell.reuseId)
        
        regionCollection.edgesToSuperview(insets: .right(10) + .left(10))
    }
    
    private func setupSelectionBar() {
        let selectionBar = UIView()
        addSubview(selectionBar)
        
        if #available(iOS 13.0, *) {
            selectionBar.backgroundColor = .systemIndigo
        } else {
            selectionBar.backgroundColor = #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1)
        }
        selectionBar.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalBarAnchor = selectionBar.leadingAnchor.constraint(equalTo: regionCollection.leadingAnchor)
        horizontalBarAnchor?.isActive = true
        
        selectionBar.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        selectionBar.widthAnchor.constraint(equalTo: regionCollection.widthAnchor, multiplier: alignment).isActive = true
        selectionBar.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    private func playAnimation(for item: IndexPath) {
        let width = regionCollection.frame.width / 3
        let x = CGFloat(item.item) * width
        
        horizontalBarAnchor?.constant = x
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
}

extension RegionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegionCollectionViewCell.reuseId, for: indexPath) as! RegionCollectionViewCell
        
        cell.regionName.text = regions[indexPath.row].rawValue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playAnimation(for: indexPath)
        delegate?.userDidChooseRegion(regions[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: regionCollection.frame.width / 3, height: regionCollection.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
