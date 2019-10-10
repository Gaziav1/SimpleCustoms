//
//  DeclarantTableViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 04/10/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class DeclarantTableViewController: UITableViewController {
    
    private var goodsInformation = [GoodsWithLimitations]()
    
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
        goodsInformation = RealmManager.sharedInstance.retrieveAllDataForObject(GoodsWithLimitations.self) as! [GoodsWithLimitations]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func getData() {
        CurrencyFetcher.shared.getCurrency(completion: { (currencyEx, error) in
            guard error == nil else {
                self.resultLabel.text = "Не удалось получить текущий курс евро"
                self.resultLabel.fadeIn()
                return }
            self.resultLabel.text = ""
            self.currency = currencyEx!
        })
    }
    
    private func drawLine(of color: [UIColor]) {
        let aPath = UIBezierPath()
        let shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        shapeLayer.frame = view.bounds
        aPath.move(to: CGPoint(x:0, y: self.declarationInfoLabel.frame.minY + 50))
        aPath.addLine(to: CGPoint(x: self.declarationInfoLabel.frame.maxX, y: self.declarationInfoLabel.frame.minY + 50))
        
        shapeLayer.path = aPath.cgPath
        shapeLayer.strokeColor = color.randomElement()?.cgColor
        shapeLayer.lineWidth = 0.9
        shapeLayer.strokeEnd = 0
        let animaton = CABasicAnimation()
        animaton.value(forKey: "strokeEnd")
        animaton.toValue = 1
        animaton.duration = 0.3
        animaton.fillMode = .forwards
        animaton.isRemovedOnCompletion = false
        shapeLayer.add(animaton, forKey: "strokeEnd")
    }
    
    private func setupUIElements() {
        currencyToConvertLabel.delegate = self
        currencyToConvertLabel.font = currencyToConvertLabel.font?.withSize(17)
        resultLabel.isHidden = true
        resultImage.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(tap)
    }
    
    private func setupPickerView() {
        goodsPicker.delegate = self
        goodsPicker.dataSource = self
    }
    
}

extension DeclarantTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return goodsInformation.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = NSAttributedString(string: goodsInformation[row].productName, attributes:  [.foregroundColor: UIColor.white])
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return goodsInformation[row].productName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        declarationInfoLabel.textColor = .white
        drawLine(of: Colors.colors)
        declarationInfoLabel.font = declarationInfoLabel.font.withSize(19)
        declarationInfoLabel.text = goodsInformation[row].productLimitations
    }
}

extension DeclarantTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text, let recievedCurrency = Int(text) else { return }
        guard let currentCurrency = currency else { return }
        
        let exchanger = CurrencyExchanger(valueToExchange: recievedCurrency, currency: currentCurrency)
        convertedCurrencyLabel.text = exchanger.resultToShow
        
        resultLabel.fadeIn()
        resultImage.fadeIn()
        
        if exchanger.getResult() {
            
            resultImage.image = UIImage(named: "checked")
            resultLabel.text = "Вам не нужно декларировать валюту"
        } else {
            resultImage.image = UIImage(named: "cancel")
            resultLabel.text = "Вам необходимо задекларировать валюту"
        }
    }
}

