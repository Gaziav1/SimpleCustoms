//
//  TableViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 01.12.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import RealmSwift

protocol ChooseCurrencyDelegate: class {
    func userDidChooseCurrency(_ currency: Currency)
}

class TableViewController: UITableViewController {

    weak var delegate: ChooseCurrencyDelegate?
    private var currenciesToShow = [CustomsRules]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currenciesToShow = RealmManager.sharedInstance.retrieveAllDataForObject(CustomsRules.self) as! [CustomsRules]
        
        self.tableView.register(UINib(nibName: "CurrencyChoosingableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyChoosing")
        self.title = "Выберите валюту"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesToShow.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyChoosing", for: indexPath) as! CurrencyChoosingableViewCell
        cell.currencyName.text = currenciesToShow[indexPath.row].currency?.name
        cell.countryName.text = currenciesToShow[indexPath.row].forCountryCode
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.userDidChooseCurrency(currenciesToShow[indexPath.row].currency ?? Currency())
    }

}
