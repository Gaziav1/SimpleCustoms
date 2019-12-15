//
//  GoodsChoosingAlert.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 06.12.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import RealmSwift

protocol GoodsChoosingDelegate: class {
    func cancelButtonTapped()
    func doneButtonTapped(choosen goods: String, limitations: String)
}

protocol GoodsChoosingDataSource: class {
    func goodsToShow() -> List<GoodsWithLimitations>
}

class GoodsChoosingAlert: UIView {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var blurEffect: UIVisualEffectView! {
        didSet {
            if #available(iOS 13.0, *) {
                blurEffect.effect = UIBlurEffect(style: .systemChromeMaterial)
            } else {
                blurEffect.effect = UIBlurEffect(style: .prominent)
            }
        }
    }
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var goodsPickerView: UIPickerView!
    private var limitations = ""
    private var choosenGoods = ""
    weak var delegate: GoodsChoosingDelegate?
    weak var dataSource: GoodsChoosingDataSource?
    
    override func awakeFromNib() {
        goodsPickerView.delegate = self
        goodsPickerView.dataSource = self
    
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        delegate?.doneButtonTapped(choosen: choosenGoods, limitations: limitations)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        delegate?.cancelButtonTapped()
    }
}

extension GoodsChoosingAlert: UIPickerViewDelegate, UIPickerViewDataSource {
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
    
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            guard let data = dataSource?.goodsToShow()[0] else { return 0 }
            choosenGoods = data.productName
            limitations = data.productLimitations
            return dataSource?.goodsToShow().count ?? 0
        }
    

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
            return dataSource?.goodsToShow()[row].productName 
        }
    
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            guard let data = dataSource?.goodsToShow()[row] else { return }
            choosenGoods = data.productName
            limitations = data.productLimitations
        }
}

