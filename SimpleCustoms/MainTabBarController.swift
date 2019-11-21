//
//  MainTabBarController.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 21.11.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationController = UINavigationController(rootViewController: CountryViewController())
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.8588235294, green: 0.8862745098, blue: 0.9137254902, alpha: 1)
        
        viewControllers = [navigationController, DeclarantTableViewController()]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
