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
        
        // Загрузка предварительно заполненной базы данных
        guard let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path else { return true } //определяем путь до незаполненной базы данных
        let path = Bundle.main.path(forResource: "default", ofType: "realm") //определяем путь до заполненной базы данных, которая находится в нашем бандле
      
        if !FileManager.default.fileExists(atPath: defaultPath), let bundledPath = path {
            do {
                //проверяем наличие файла по данному пути, в случае его отсутствия копируем туда предварительно заполненною базу данных
                try FileManager.default.copyItem(atPath: bundledPath, toPath: defaultPath)
            } catch {
                print("Error copying pre-populated Realm \(error)")
            }
            
        }
        
        RealmManager.sharedInstance.realmObject = try! Realm()
        return true
    }

}

