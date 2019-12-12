//
//  AppDelegate.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 04/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    
        if let text = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            print(text)
        }
        RealmManager.sharedInstance.realmMigrateIfNeeded(to: 34)
        //RealmManager.sharedInstance.updateOrCreateDB()

        return true
    }
    
}

