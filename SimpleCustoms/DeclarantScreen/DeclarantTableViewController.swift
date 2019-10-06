//
//  DeclarantTableViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 04/10/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class DeclarantTableViewController: UITableViewController {
    
    private let goodsInformation = RealmManager.sharedInstance.retrieveAllDataForObject(GoodsWithLimitations.self) as! [GoodsWithLimitations]
    
    private var currency: Currency?
    
    @IBOutlet weak var declarationInfoLabel: UILabel!
    @IBOutlet weak var goodsPicker: UIPickerView!
    @IBOutlet weak var currencyToConvertLabel: UITextField!
    @IBOutlet weak var convertedCurrencyLabel: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIElements()
        getData()
        setupPickerView()
        
        
    }
    
    private func getData() {
        CurrencyFetcher.shared.getCurrency(completion: { (currencyEx, error) in
            guard error == nil else {
                self.resultLabel.text = "Не удалось получить данные о текущем курсе евро"
                return }
            self.currency = currencyEx!
        })
    }
    
    private func setupUIElements() {
        currencyToConvertLabel.delegate = self
        currencyToConvertLabel.font = currencyToConvertLabel.font?.withSize(18)
        resultLabel.isHidden = true
        resultImage.isHidden = true
    }
    
    private func setupPickerView() {
        goodsPicker.setValue(UIColor.white, forKey: "textColor")
        goodsPicker.delegate = self
        goodsPicker.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        currencyToConvertLabel.resignFirstResponder()
    }
}

extension DeclarantTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return goodsInformation.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return goodsInformation[row].productName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        declarationInfoLabel.textColor = .white
        declarationInfoLabel.font = declarationInfoLabel.font.withSize(17)
        declarationInfoLabel.text = goodsInformation[row].productLimitations
    }
}

extension DeclarantTableViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text, let recievedCurrency = Int(text) else { return }
        guard let currentCurrency = currency else { return }
        
        let exchanger = CurrencyExchanger(valueToExchange: recievedCurrency, currency: currentCurrency)
        convertedCurrencyLabel.text = exchanger.resultToShow
       
        resultLabel.isHidden = false
        resultImage.isHidden = false
        
        if exchanger.getResult() {
            
            resultImage.image = UIImage(named: "checked")
            resultLabel.text = "Вам не нужно декларировать валюту"
        } else {
            resultImage.image = UIImage(named: "cancel")
            resultLabel.text = "Вам необходимо задекларировать валюту"
        }
    }
}

