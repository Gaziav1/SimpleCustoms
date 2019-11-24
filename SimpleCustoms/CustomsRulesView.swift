//
//  CustomsRulesView.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 24.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

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
        page.currentPage = 0
        page.numberOfPages = 5
        page.currentPageIndicatorTintColor = .systemPurple
        page.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return page
    }()
    
    private let rightDirectionImage: UIImageView = {
        let image = UIImage(named: "icons8-right-100")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.1
        return imageView
    }()
    
    private let leftDirectionImage: UIImageView = {
        let image = UIImage(named: "icons8-left-100")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.1
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var lastPoint: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupPageControl()
        setupDirectionButtons()
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
        
        rulesCollection.topAnchor.constraint(equalTo: topAnchor).isActive = true
        rulesCollection.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        rulesCollection.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        rulesCollection.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    func setupDirectionButtons() {
        addSubview(rightDirectionImage)
        addSubview(leftDirectionImage)
        
        NSLayoutConstraint.activate([
            rightDirectionImage.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
            rightDirectionImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
           
            leftDirectionImage.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
            leftDirectionImage.leadingAnchor.constraint(equalTo: leadingAnchor)
            
        ])
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        // x отражает нашу текущую позицию в скролл вью
        
        let point = Int(x / frame.width)
        
        leftDirectionImage.isHidden = point == 0 ? true : false
        rightDirectionImage.isHidden = point == lastPoint ? true : false
        
        pageControl.currentPage = Int(x / frame.width)
        
    }
}

extension CustomsRulesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RulesCollectionViewCell.reuseId, for: indexPath)
        
        lastPoint = indexPath.last ?? nil
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
