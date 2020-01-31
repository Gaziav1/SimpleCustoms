//
//  ErrorView.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 20.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit


class ErrorView: UIView {
    
    let buttonForError: UIButton = {
        let button = UIButton()
        button.setTitle("Обновить", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.5529411765, blue: 0.7803921569, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let labelForError: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.5764705882, alpha: 1)
        label.text = "К сожалению загрузка данных не удалась. Пожалуйста, попытайтесь позднее."
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageForError: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sad2")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {

      addSubview(imageForError)
      addSubview(labelForError)
      addSubview(buttonForError)
        
        NSLayoutConstraint.activate([
            imageForError.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            imageForError.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            labelForError.topAnchor.constraint(equalTo: imageForError.bottomAnchor, constant: 25),
            labelForError.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelForError.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            buttonForError.topAnchor.constraint(equalTo: labelForError.bottomAnchor, constant: 25),
            buttonForError.centerXAnchor.constraint(equalTo: imageForError.centerXAnchor),
            buttonForError.widthAnchor.constraint(equalToConstant: 300),
            buttonForError.heightAnchor.constraint(equalToConstant: 40)
        ])
        buttonForError.layer.cornerRadius = 10
        buttonForError.layer.masksToBounds = true
    }
}
