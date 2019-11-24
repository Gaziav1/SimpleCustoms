//
//  CustomsViewController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 11/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import RealmSwift

class CustomsViewController: UIViewController {
    
    var rules: CustomsRules? {
        didSet {
            flagImage.image = UIImage(named: rules?.forCountryCode?.lowercased() ?? "fr")
        }
    }
    
    var flagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let countryDescription: UILabel = {
        let label = UILabel()
        label.text = "Канада славится своими практически нетронутыми природными ландшафтами, а также уникальной мозаичной культурой, составленной из самых разных традиций, привнесенных эмигрантами из всех уголков мира."
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 17.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionView: CountryDescriptionView = {
        let view = CountryDescriptionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupImage()
        setupDescriptionView()
        setupCountryDescription()
    }
    
    private func setupNavigationController() {
        view.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func setupImage() {
        view.addSubview(flagImage)
        
        NSLayoutConstraint.activate([
            
            flagImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            flagImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            flagImage.widthAnchor.constraint(equalToConstant: 215),
            flagImage.heightAnchor.constraint(equalToConstant: 150)])
        
        flagImage.layer.cornerRadius = 20
        flagImage.layer.masksToBounds = true
    }
    
    private func setupDescriptionView() {
        view.addSubview(descriptionView)
        
        NSLayoutConstraint.activate([
            descriptionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: flagImage.safeAreaLayoutGuide.trailingAnchor),
            descriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            descriptionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupCountryDescription() {
        view.addSubview(countryDescription)
        NSLayoutConstraint.activate([
            countryDescription.topAnchor.constraint(equalTo: flagImage.bottomAnchor, constant: 30),
            countryDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            countryDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)])
    }
    
}

//extension CustomsViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let rules = rules else { return 1 }
//        return rules.customsRule.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: CustomsRulesTableViewCell.reuseIdentifier, for: indexPath) as! CustomsRulesTableViewCell
//        guard let rules = rules else { return cell }
//
//        cell.rulesTypeLabel.text = rules.customsRule[indexPath.row].header
//
//        let text = rules.customsRule[indexPath.row].body.replacingOccurrences(of: "\\n", with: "\n") //обеспечивает начало текста с новой строки при загрузке текста из базы данных
//
//        cell.rulesLabel.text = text
//        cell.customsHeaderView.backgroundColor = Colors.colors[indexPath.row]
//        cell.rulesLabel.frame = CustomsRulesCellLayout.shared.size(for: cell.rulesLabel.text!)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//       return CustomsRulesCellLayout.shared.totalHeight
//
//    }
//}



