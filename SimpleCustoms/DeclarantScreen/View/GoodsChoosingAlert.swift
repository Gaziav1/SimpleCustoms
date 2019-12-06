//
//  GoodsChoosingAlert.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 06.12.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

protocol GoodsChoosingDelegate: class {
    func cancelButtonTapped()
    func doneButtonTapped()
}

class GoodsChoosingAlert: UIView {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var goodsPickerView: UIPickerView!
    
    weak var delegate: GoodsChoosingDelegate?
    
    override func awakeFromNib() {
         translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        delegate?.doneButtonTapped()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        delegate?.cancelButtonTapped()
    }
}
