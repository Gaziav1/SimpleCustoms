//
//  DeclarantTableViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 04/10/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import TinyConstraints
import RealmSwift

class DeclarantTableViewController: UIViewController {
    
    private var goodsInformation = RealmManager.sharedInstance.retrieveAllDataForObject(CustomsRules.self) as! [CustomsRules]
    
    //private var currency: Currency?

     lazy private var goodsAlert: GoodsChoosingAlert = {
         var viewAlert = GoodsChoosingAlert()
         viewAlert = Bundle.main.loadNibNamed("GoodsChoosingAlert", owner: self, options: nil)?.first as! GoodsChoosingAlert
         viewAlert.alpha = 0
         viewAlert.delegate = self
         viewAlert.dataSource = self
        return viewAlert
     }()
    
    lazy private var currencyView: CurrencyChoosingView = {
        var view = CurrencyChoosingView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let segmentedTypeControl: UISegmentedControl = {
       let sc = UISegmentedControl(items: ["Товары", "Валюта"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        let font = UIFont.systemFont(ofSize: 16)
        sc.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        return sc
    }()
    
    private let goodsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .secondarySystemBackground
        } else {
            tableView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        }
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CountryChooserTableViewCell", bundle: nil), forCellReuseIdentifier: CountryChooserTableViewCell.cellId)
        tableView.estimatedRowHeight = 115
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect: UIBlurEffect
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        } else {
            blurEffect = UIBlurEffect(style: .extraLight)
        }
        
        let effect = UIVisualEffectView(effect: blurEffect)
        effect.translatesAutoresizingMaskIntoConstraints = false
        effect.alpha = 0
        return effect
    }()
    
    private var choosenGoods: String = ""
    
    private var rowNumber = 1
    private var flagImage = UIImage()
    private var choosenCountry = [String: String]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemBackground
        } else {
            view.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        }
        goodsInformation = RealmManager.sharedInstance.retrieveAllDataForObject(CustomsRules.self) as! [CustomsRules]
        setupSegmentedControl()
        setupGoodsView()
        setupCurrencyView()
        setupVisualEffectView()
    }
    
    private func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.edgesToSuperview()
    }
    
    private func setupSegmentedControl() {
        view.addSubview(segmentedTypeControl)
        segmentedTypeControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        segmentedTypeControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        segmentedTypeControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        segmentedTypeControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        segmentedTypeControl.addTarget(self, action: #selector(segmentedControlSelection), for: .valueChanged)
    }
    
    private func setupGoodsView() {
        goodsTableView.translatesAutoresizingMaskIntoConstraints = false
        goodsTableView.delegate = self
        goodsTableView.dataSource = self
        view.addSubview(goodsTableView)
        
        goodsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        goodsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        goodsTableView.topAnchor.constraint(equalTo: segmentedTypeControl.bottomAnchor, constant: 35).isActive = true
        goodsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setupCurrencyView() {
        view.addSubview(currencyView)
        if #available(iOS 13.0, *) {
            currencyView.backgroundColor = .quaternarySystemFill
        } else {
            currencyView.backgroundColor = .white
        }
        
        currencyView.edgesToSuperview(excluding: .bottom, insets: .top(100) + .right(10) + .left(10), usingSafeArea: true)
        currencyView.height(view.frame.height / 2)
    }
    
    private func animateIn() {
        goodsAlert.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        goodsAlert.fadeIn()
        visualEffectView.fadeIn()
        UIView.animate(withDuration: 0.3) {
            self.goodsAlert.transform = CGAffineTransform.identity
        }
    }
    
    @objc private func segmentedControlSelection(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
        goodsTableView.fadeIn()
        currencyView.fadeOut()
        case 1:
        goodsTableView.fadeOut()
        currencyView.fadeIn()
        default: print("fag")
        }
    }
}

extension DeclarantTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryChooserTableViewCell.cellId, for: indexPath) as! CountryChooserTableViewCell
        
        cell.number.text = String(indexPath.row + 1)
        cell.indexPath = indexPath.row
        
        switch indexPath.row {
        case 0:
            cell.choosenEntity.text = choosenCountry["name"]
            cell.flagImage.image = flagImage
        case 2:
            cell.isUserInteractionEnabled = false
            cell.bottomConstraint.isActive = true
            cell.heightContainer.isActive = false
            cell.type.text = choosenGoods
        default: print("dick")
        }
        
        cell.isReloaded = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            return UITableView.automaticDimension
        default:
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CountryViewController()
        let nc = UINavigationController(rootViewController: vc)
        vc.title = "Выберите страну"
 
        switch indexPath.row {
        case 0:
            vc.delegate = self
            self.present(nc, animated: true) {
                self.rowNumber = 1
                self.goodsTableView.reloadData()
            }
        case 1:
            view.addSubview(goodsAlert)
            goodsAlert.center = view.center
            animateIn()

        default: return
        }
    }
}

extension DeclarantTableViewController: CountryChooseDelegate {
    
    func didChooseCountry(_ name: String, code: String, imageData: Data) {
        self.choosenCountry["name"] = name
        self.choosenCountry["countryCode"] = code
        
        guard let dataForImage = UIImage(data: imageData) else { return }
        flagImage = dataForImage
        self.rowNumber = 2
        goodsTableView.reloadData()
        dismiss(animated: true)
    }
}

extension DeclarantTableViewController: GoodsChoosingDelegate, GoodsChoosingDataSource {
    func cancelButtonTapped() {
        goodsAlert.removeFromSuperview()
        visualEffectView.fadeOut()
    }
    
    func doneButtonTapped(_ entity: String) {
        choosenGoods = entity
        print(entity)
        goodsAlert.removeFromSuperview()
        rowNumber = 3
        goodsTableView.reloadData()
        visualEffectView.fadeOut()
    }
    
    func goodsToShow() -> List<GoodsWithLimitations> {
        
        return goodsInformation.first(where: { $0.forCountryCode == choosenCountry["countryCode"] })?.goodsLimitations ?? List<GoodsWithLimitations>()
    }
}

extension DeclarantTableViewController: CurrencySelectorDelegate, ChooseCurrencyDelegate {
    func didSelectCurrencyButton() {
        let tableCurrency = TableViewController()
        tableCurrency.delegate = self
        let nc = UINavigationController(rootViewController: tableCurrency)
        nc.navigationBar.isTranslucent = false
        nc.navigationBar.barTintColor = #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1)
        nc.navigationBar.tintColor = .white

        self.present(nc, animated: true, completion: nil)
    }
    
    func userDidChooseCurrency(_ currency: Currency) {
        
        currencyView.currencyChoosingButton.setTitle(currency.symbol, for: .normal)
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
