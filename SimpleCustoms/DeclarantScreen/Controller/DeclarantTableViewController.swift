//
//  DeclarantTableViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 04/10/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class DeclarantTableViewController: UIViewController {
    
    //private var goodsInformation = [GoodsWithLimitations]()
    
    //private var currency: Currency?
    
    let goodsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "GoodsTableViewCell", bundle: nil), forCellReuseIdentifier: GoodsTableViewCell.cellId)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemBackground
        } else {
            view.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        }
        
        setupGoodsView()
    }
    
    func setupGoodsView() {
        goodsTableView.translatesAutoresizingMaskIntoConstraints = false
        goodsTableView.delegate = self
        goodsTableView.dataSource = self
        view.addSubview(goodsTableView)
        
        goodsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        goodsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        goodsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        goodsTableView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
}

extension DeclarantTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoodsTableViewCell.cellId, for: indexPath) as! GoodsTableViewCell
        return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.present(TableViewController(), animated: true, completion: nil)
        //case 1:
            
        default:
            return
        }
    }
}


//        goodsInformation = RealmManager.sharedInstance.retrieveAllDataForObject(GoodsWithLimitations.self) as! [GoodsWithLimitations]
//    override func viewDidAppear(_ animated: Bool) {
//        getData()
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//
//    private func getData() {
//        CurrencyFetcher.shared.getCurrency(completion: { (currencyEx, error) in
//            guard error == nil else {
//                self.resultLabel.text = "Не удалось получить текущий курс евро"
//                self.resultLabel.fadeIn()
//                return }
//            self.resultLabel.text = ""
//            self.currency = currencyEx!
//        })
//    }
//
//    private func setupUIElements() {
//        currencyToConvertLabel.delegate = self
//        currencyToConvertLabel.font = currencyToConvertLabel.font?.withSize(17)
//        resultLabel.isHidden = true
//        resultImage.isHidden = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tableView.addGestureRecognizer(tap)
//    }
//
//    private func setupPickerView() {
//        goodsPicker.delegate = self
//        goodsPicker.dataSource = self
//    }
//
//}
//
//extension DeclarantTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//        return goodsInformation.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let title = NSAttributedString(string: goodsInformation[row].productName, attributes:  [.foregroundColor: UIColor.white])
//        return title
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        return goodsInformation[row].productName
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        declarationInfoLabel.textColor = .white
//        declarationInfoLabel.font = declarationInfoLabel.font.withSize(19)
//        declarationInfoLabel.text = goodsInformation[row].productLimitations
//    }
//}
//
//extension DeclarantTableViewController: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        return true
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        guard let text = textField.text, let recievedCurrency = Int(text) else { return }
//        guard let currentCurrency = currency else { return }
//
//        let exchanger = CurrencyExchanger(valueToExchange: recievedCurrency, currency: currentCurrency)
//        convertedCurrencyLabel.text = exchanger.resultToShow
//
//        resultLabel.fadeIn()
//        resultImage.fadeIn()
//
//        if exchanger.getResult() {
//
//            resultImage.image = UIImage(named: "checked")
//            resultLabel.text = "Вам не нужно декларировать валюту"
//        } else {
//            resultImage.image = UIImage(named: "cancel")
//            resultLabel.text = "Вам необходимо задекларировать валюту"
//        }
//    }
//}
//
