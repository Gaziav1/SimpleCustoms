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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        setupUIElements()
    }
    
    private func setupUIElements() {
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
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



