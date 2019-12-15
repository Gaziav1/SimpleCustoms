//
//  CountryDescriptionTableView.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 24.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import TinyConstraints

class CountryDescriptionView: UIView {
    
    private var containterTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        return tableView
    }()
    
    var infoForCell: CountryInfoForCell?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillCell(with info: CountryInfoForCell, cell: DescriptionTableViewCell, at indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            cell.titleDescription.text = "Столица"
            cell.descriptionAnswer.text = info.capital
        case 1:
            cell.titleDescription.text = "Валюта"
            cell.descriptionAnswer.text = info.currency
        case 2:
            cell.titleDescription.text = "Язык"
            cell.descriptionAnswer.text = info.language
        default:
            print("hello there")
        }
    }
    
    
    private func setupTableView() {
        addSubview(containterTableView)
        containterTableView.delegate = self
        containterTableView.dataSource = self
        
        containterTableView.edgesToSuperview()
        
        containterTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: DescriptionTableViewCell.reuseId)
    }
}

extension CountryDescriptionView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.reuseId, for: indexPath) as! DescriptionTableViewCell
        
        if let info = infoForCell {
            fillCell(with: info, cell: cell, at: indexPath)
        }
        
        if #available(iOS 13.0, *) {
            cell.backgroundColor = .secondarySystemBackground
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
}
