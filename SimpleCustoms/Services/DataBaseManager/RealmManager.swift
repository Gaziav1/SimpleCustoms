//
//  RealmManager.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 24/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {
    
    var realmObject: Realm?
    
    private var configuration: Realm.Configuration = .defaultConfiguration
    
    static let sharedInstance = RealmManager()
    
    func retrieveAllDataForObject(_ T : Object.Type) -> [Object] {
        
        var objects = [Object]()
        guard let realm = realmObject else { return objects }
        for result in realm.objects(T) {
            objects.append(result)
        }
        return objects
    }
    
    func filter(_ predicate: NSPredicate, object: Object.Type) -> [Object] {
        var objects = [Object]()
        guard let realm = realmObject else { return objects }
        for result in realm.objects(object).filter(predicate) {
            objects.append(result)
        }
        return objects
    }
    
    func add(_ objects : [Object]) {
        
        guard let realm = realmObject else { return }
        try! realm.write {
            
            realm.add(objects)
        }
    }
    
    func delete(_ objects : [Object]) {
        guard let realm = realmObject else { return  }
        try! realm.write{
            realm.delete(objects)
        }
    }
    
    func realmMigrate(to version: UInt64) {
       configuration = Realm.Configuration(
            schemaVersion: version,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < version {
                    UserDefaults.standard.set(false, forKey: "isDataBaseUpdated")
                    print("hreuy")
                }
        })
    }
    
    func updateOrCreateDB() {
        // Загрузка предварительно заполненной базы данных
             guard let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path else { return } //определяем путь до незаполненной базы данных
        guard let path = Bundle.main.path(forResource: "default", ofType: "realm") else { return } //определяем путь до заполненной базы данных, которая находится в нашем бандле
           
             if !FileManager.default.fileExists(atPath: defaultPath) {
                 do {
                     //проверяем наличие файла по данному пути, в случае его отсутствия копируем туда предварительно заполненною базу данных
                     UserDefaults.standard.set(true, forKey: "isDataBaseUpdated")
                     try FileManager.default.copyItem(atPath: path, toPath: defaultPath)
                 } catch {
                     print("Error copying pre-populated Realm \(error)")
                 }
             }
             
             //Обновление уже сущещствующей у юзера базы данных
             if !UserDefaults.standard.bool(forKey: "isDataBaseUpdated")  {
                 do {
                     UserDefaults.standard.set(true, forKey: "isDataBaseUpdated")
                     try FileManager.default.removeItem(atPath: defaultPath)
                     try FileManager.default.copyItem(atPath: path, toPath: defaultPath)
                 } catch  {
                     print("Error")
                 }
             }
             
            realmObject = try! Realm(configuration: configuration)
    }
}


