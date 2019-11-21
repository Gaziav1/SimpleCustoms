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
                UserDefaults.standard.set(true, forKey: "isDataBaseUpdated")
                try FileManager.default.copyItem(atPath: bundledPath, toPath: defaultPath)
            } catch {
                print("Error copying pre-populated Realm \(error)")
            }
        }
        
        //Обновление уже сущещствующей у юзера базы данных 
        if !UserDefaults.standard.bool(forKey: "isDataBaseUpdated"), let bundledPath = path {
            do {
                UserDefaults.standard.set(true, forKey: "isDataBaseUpdated")
                try FileManager.default.removeItem(atPath: defaultPath)
                try FileManager.default.copyItem(atPath: bundledPath, toPath: defaultPath)
            } catch  {
                print("Error")
            }
        }
        
        RealmManager.sharedInstance.realmObject = try! Realm()
        return true
    }

}

