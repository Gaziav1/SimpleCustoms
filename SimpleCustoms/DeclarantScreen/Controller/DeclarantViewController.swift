//
//  DeclarantTableViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 04/10/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import TinyConstraints
import Lottie
import RealmSwift

class DeclarantViewController: UIViewController {
    
    private var goodsInformation = [CustomsRules]()
    
    private var currencyExchanger: CurrencyExchanger?
    
    lazy private var goodsAlert: GoodsChoosingAlert = {
        var viewAlert = GoodsChoosingAlert()
        viewAlert = Bundle.main.loadNibNamed("GoodsChoosingAlert", owner: self, options: nil)?.first as! GoodsChoosingAlert
        viewAlert.alpha = 0
        viewAlert.delegate = self
        viewAlert.dataSource = self
        viewAlert.translatesAutoresizingMaskIntoConstraints = false
        return viewAlert
    }()
    
    lazy private var currencyView: CurrencyChoosingView = {
        var view = CurrencyChoosingView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private var currentExchangeRates: Float = 0
    
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
            blurEffect = UIBlurEffect(style: .light)
        }
        
        let effect = UIVisualEffectView(effect: blurEffect)
        effect.translatesAutoresizingMaskIntoConstraints = false
        effect.alpha = 0
        return effect
    }()
    
    private var choosenGoods = [String: String]()
    private var rowNumber = 1
    private var flagImage = UIImage()
    private var choosenCountry = [String: String]() //словарь так как необходимо название страны и ее код
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CurrencyFetcher.shared.getCurrency(currency: "EUR") { (curr, error) in
            guard curr != nil else { return }
            self.currencyExchanger = CurrencyExchanger(currency: curr!)
        }
        
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
    
    
    private func setupGoodsAlert() {
        view.addSubview(goodsAlert)
        
        goodsAlert.center(in: view)
        goodsAlert.width(view.frame.width - 10)
        goodsAlert.height(view.frame.height / 2.5)
    }
    
    private func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.edgesToSuperview()
    }
    
    private func setupSegmentedControl() {
        view.addSubview(segmentedTypeControl)
        
        segmentedTypeControl.left(to: view, offset: 15)
        segmentedTypeControl.right(to: view, offset: -15)
        segmentedTypeControl.top(to: view.safeAreaLayoutGuide, offset: 25)
        segmentedTypeControl.height(37)
        
        segmentedTypeControl.addTarget(self, action: #selector(segmentedControlSelection), for: .valueChanged)
    }
    
    private func setupGoodsView() {
        goodsTableView.translatesAutoresizingMaskIntoConstraints = false
        goodsTableView.delegate = self
        goodsTableView.dataSource = self
        view.addSubview(goodsTableView)
        
        goodsTableView.right(to: view, offset: 5)
        goodsTableView.left(to: view)
        goodsTableView.topToBottom(of: segmentedTypeControl, offset: 35)
        goodsTableView.bottom(to: view)
    }
    
    private func setupCurrencyView() {
        view.addSubview(currencyView)
        if #available(iOS 13.0, *) {
            currencyView.backgroundColor = .quaternarySystemFill
        } else {
            currencyView.backgroundColor = .white
        }
        
        currencyView.edgesToSuperview(excluding: .bottom, insets: .top(100) + .right(10) + .left(10), usingSafeArea: true)
        currencyView.height(view.frame.height / 1.5)
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
        default: print("hello there")
        }
    }
}

extension DeclarantViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        case 1:
            if let goods = choosenGoods["goods"] {
                cell.type.text = goods
            }
        case 2:
            cell.isUserInteractionEnabled = false
            if let limitations = choosenGoods["limitations"] {
                cell.type.text = limitations
            }
        default: break
        }
        
        return cell
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
            setupGoodsAlert()
            animateIn()
            
        default: return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension DeclarantViewController: CountryChooseDelegate {
    
    func didChooseCountry(_ name: String, code: String, imageData: Data) {
        self.choosenCountry["name"] = name
        self.choosenCountry["countryCode"] = code
        self.choosenGoods["goods"] = "Товары"
        self.choosenGoods["limitations"] = ""
        guard let dataForImage = UIImage(data: imageData) else { return }
        flagImage = dataForImage
        self.rowNumber = 2
        goodsTableView.reloadData()
        dismiss(animated: true)
    }
}

extension DeclarantViewController: GoodsChoosingDelegate, GoodsChoosingDataSource {
    func doneButtonTapped(choosen goods: String, limitations: String) {
        choosenGoods["goods"] = goods
        choosenGoods["limitations"] = limitations
        goodsAlert.removeFromSuperview()
        rowNumber = 3
        goodsTableView.reloadData()
        visualEffectView.fadeOut()
    }
    
    func cancelButtonTapped() {
        //срабатывает при нажатии на кнопку отмены в алерте выбора товаров
        goodsAlert.removeFromSuperview()
        visualEffectView.fadeOut()
    }
    
    
    func goodsToShow() -> List<GoodsWithLimitations> {
        
        // источник данных для показа элементов в пикервью алерта выбора товаров
        return goodsInformation.first(where: { $0.forCountryCode == choosenCountry["name"] })?.goodsLimitations ?? List<GoodsWithLimitations>()
    }
}

extension DeclarantViewController: CurrencyDelegate, ChooseCurrencyDelegate {
    
    func didTypeCurrencyValue(reverse: Bool, value: Int) -> String {
        //срабатывает при вводе количества валюты в текстфилд
        currencyExchanger?.setValueToExchange(value)
        let exchangedValue = (currencyExchanger?.exchange(reverse, value: value))!
        currencyView.playSpecificAnimation(!currencyExchanger!.isDeclarationNeeded)
        
        return exchangedValue
    }
    
    func didSelectCurrencyButton() {
        //срабатывает при нажатии на кнопку валюты
        let tableCurrency = TableViewController()
        tableCurrency.delegate = self
        let nc = UINavigationController(rootViewController: tableCurrency)
        nc.navigationBar.isTranslucent = false
        nc.navigationBar.barTintColor = #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1)
        nc.navigationBar.tintColor = .white
        
        self.present(nc, animated: true, completion: nil)
    }
    
    func userDidChooseCurrency(_ currency: Currency, for country: String) {
        //срабатывает при выборе определенной валюты в тейбл вью
        dismiss(animated: true, completion: nil)
        CurrencyFetcher.shared.getCurrency(currency: currency.symbol!) { (currentCurrency, error) in
            guard currentCurrency != nil else { return }
            self.currencyExchanger?.setCurrentRates(currentCurrency!)
            self.currencyExchanger?.setPermissibleValue(currency.limit)
        }
        
        currencyView.currencyChoosingButton.setTitle(currency.symbol, for: .normal)
        currencyView.choosenCountry.text = "Страна следования: \(country)"
    }
}


