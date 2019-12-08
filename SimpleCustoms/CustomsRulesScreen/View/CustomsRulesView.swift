//
//  CustomsRulesView.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 24.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import RealmSwift
import TinyConstraints

class CustomsRulesView: UIView {
    
    private let rulesCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let page = UIPageControl()
     
        if #available(iOS 13.0, *) {
            page.currentPageIndicatorTintColor = .systemIndigo
        } else {
            page.currentPageIndicatorTintColor = #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1)
        }
        page.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return page
    }()
    
    var rules = List<CustomsRuleDescription>() {
        didSet {
            pageControl.numberOfPages = rules.count
            pageControl.currentPage = 0
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupPageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPageControl() {
        addSubview(pageControl)
        
        pageControl.bottomAnchor.constraint(equalTo: rulesCollection.topAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupCollectionView() {
        addSubview(rulesCollection)
        rulesCollection.delegate = self
        rulesCollection.dataSource = self
        rulesCollection.register(UINib(nibName: "RulesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RulesCollectionViewCell.reuseId)
        
        rulesCollection.edgesToSuperview()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        // x отражает нашу текущую позицию в скролл вью
        
        let point = Int(x / frame.width)
        
        pageControl.currentPage = point
    }
}

extension CustomsRulesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RulesCollectionViewCell.reuseId, for: indexPath) as! RulesCollectionViewCell
        
        cell.header.text = rules[indexPath.row].header
        cell.body.text = rules[indexPath.row].body.replacingOccurrences(of: "\\n", with: "\n")
        print(cell.frame.height)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rules.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
