//
//  CustomsViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 11/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import RealmSwift

class CustomsViewController: UIViewController {
    
    var rules: CustomsRules?
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "CustomsRulesTableViewCell", bundle: nil), forCellReuseIdentifier: CustomsRulesTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    let imageFlag: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIElements()
        navigationItem.titleView = imageFlag
    }
    
    
    private func setupUIElements() {
        self.view.addSubview(imageFlag)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.1568627451, alpha: 1)
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            tableView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0)])
    }
}

extension CustomsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rules = rules else { return 1 }
        return rules.customsRule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomsRulesTableViewCell.reuseIdentifier, for: indexPath) as! CustomsRulesTableViewCell
        guard let rules = rules else { return cell }
        
        cell.rulesTypeLabel.text = rules.customsRule[indexPath.row].header
        
        let text = rules.customsRule[indexPath.row].body.replacingOccurrences(of: "\\n", with: "\n") //обеспечивает начало текста с новой строки при загрузке текста из базы данных
        
        cell.rulesLabel.text = text
        cell.customsHeaderView.backgroundColor = Colors.colors[indexPath.row]
        cell.rulesLabel.frame = CustomsRulesCellLayout.shared.size(for: cell.rulesLabel.text!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return CustomsRulesCellLayout.shared.totalHeight 
   
    }
}



