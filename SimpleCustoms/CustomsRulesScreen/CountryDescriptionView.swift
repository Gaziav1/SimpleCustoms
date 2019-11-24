//
//  CountryDescriptionTableView.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 24.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class CountryDescriptionView: UIView {
    
    var capitalCity: UILabel = {
        var label = UILabel()
        label.text = "London"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var language: UILabel = {
        var label = UILabel()
        label.text = "English"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var currency: UILabel = {
        var label = UILabel()
        label.text = "Pounds"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var containterTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupTableView() {
        addSubview(containterTableView)
        containterTableView.delegate = self
        containterTableView.dataSource = self
        
        containterTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containterTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containterTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containterTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        containterTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: DescriptionTableViewCell.reuseId)
    }
}

extension CountryDescriptionView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.reuseId, for: indexPath) as! DescriptionTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
}
