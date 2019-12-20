//
//  CurrencyChoosingView.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 08.12.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import Lottie
import TinyConstraints

protocol CurrencyDelegate: class {
    func didSelectCurrencyButton()
    func didTypeCurrencyValue(reverse exchange: Bool, value: Int) -> String
}

class CurrencyChoosingView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Декларирование валюты"
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let doneAnimation: AnimationView = {
        let animation = Animation.named("4964-check-mark-success-animation")
        var load = AnimationView()
        load.animation = animation
        load.isHidden = true
        load.animationSpeed = 2
        load.loopMode = .playOnce
        load.contentMode = .scaleAspectFit
        load.translatesAutoresizingMaskIntoConstraints = false
        return load
    }()
    
    private let rubTextField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.clearsOnBeginEditing = true
        tf.placeholder = "Кол-во перевозимой валюты"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .numberPad
        tf.borderStyle = .roundedRect
        if #available(iOS 13.0, *) {
            tf.backgroundColor = .systemFill
        } else {
            tf.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        }
        
        return tf
    }()
    
    private let choosenCurrencyField: UITextField = {
        let tf = UITextField()
        
        if #available(iOS 13.0, *) {
            tf.backgroundColor = .systemFill
        } else {
            tf.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        }
        tf.clearsOnBeginEditing = true
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.placeholder = "Кол-во иностранной валюты"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let rubLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RUB"
        return label
    }()
    
    let currencyChoosingButton: UIButton = {
        let button = UIButton()
        button.setTitle("EUR", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let choosenCountry: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    weak var delegate: CurrencyDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        setupLabel()
        setupRub()
        setupButton()
        setupCountryLabel()
        setupAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playSpecificAnimation(_ passed: Bool) {
        doneAnimation.isHidden = false
        if passed {
            resultLabel.text = "Вам не надо декларировать валюту"
            doneAnimation.animation = Animation.named("4964-check-mark-success-animation")
            doneAnimation.play()
            resultLabel.fadeIn()
            
        } else {
            resultLabel.text = "Вам необходимо декларировать валюту"
            doneAnimation.animation = Animation.named("1174-warning")
            doneAnimation.play()
            resultLabel.fadeIn()
            
        }
    }
    
    @objc private func currencySelector() {
        delegate?.didSelectCurrencyButton()
    }
    
    private func setupLabel() {
        addSubview(titleLabel)
        titleLabel.edgesToSuperview(excluding: .bottom, insets: .top(10) + .left(20))
    }
    
    private func setupCountryLabel() {
        addSubview(choosenCountry)
        
        choosenCountry.topToBottom(of: choosenCurrencyField, offset: 20)
        choosenCountry.leading(to: self, offset: 20)
        choosenCountry.text = "Выберите страну, нажав на валюту"
        if #available(iOS 13.0, *) {
            choosenCountry.textColor = .secondaryLabel
        } else {
            choosenCountry.textColor = .darkGray
        }
    }
    
    private func setupAnimation() {
        addSubview(doneAnimation)
        addSubview(resultLabel)
        doneAnimation.centerX(to: self)
        doneAnimation.topToBottom(of: choosenCountry, offset: 45)
        doneAnimation.height(60)
        doneAnimation.width(60)
        
        resultLabel.topToBottom(of: doneAnimation, offset: 15)
        resultLabel.centerX(to: self)
        
        doneAnimation.play { (_) in
            self.resultLabel.isHidden = false
        }
    }
    
    private func setupRub() {
        addSubview(rubTextField)
        addSubview(rubLabel)
        rubTextField.delegate = self
        
        rubTextField.left(to: self, offset: 20)
        rubTextField.top(to: titleLabel, offset: 55)
        rubTextField.rightToLeft(of: rubLabel, offset: -15)
        rubTextField.height(43)
        
        rubLabel.centerY(to: rubTextField)
        rubLabel.right(to: self, offset: -20)
        
    }
    
    private func setupButton() {
        addSubview(choosenCurrencyField)
        addSubview(currencyChoosingButton)
        choosenCurrencyField.delegate = self
        
        currencyChoosingButton.right(to: self, offset: -20)
        
        choosenCurrencyField.left(to: self, offset: 20)
        choosenCurrencyField.topToBottom(of: rubTextField, offset: 38)
        choosenCurrencyField.rightToLeft(of: currencyChoosingButton, offset: -14.5)
        choosenCurrencyField.height(to: rubTextField)
        
        currencyChoosingButton.centerY(to: choosenCurrencyField)
        
        currencyChoosingButton.addTarget(self, action: #selector(currencySelector), for: .touchUpInside)
    }
}

extension CurrencyChoosingView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let text = textField.text, let value = Int(text) else { return }
        
        if textField == self.rubTextField {
            choosenCurrencyField.text = delegate?.didTypeCurrencyValue(reverse: false, value: value)
        } else {
            rubTextField.text = delegate?.didTypeCurrencyValue(reverse: true, value: value)
        }
    }
}
