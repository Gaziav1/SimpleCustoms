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
    
    lazy private var configuration = Realm.Configuration(fileURL: URL(string: path))
    private var path: String {
        get {
            guard let specificPath = Bundle.main.path(forResource: "default", ofType: "realm") else { return "" }
            return specificPath
        }
    }
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
    
    func realmMigrateIfNeeded(to version: UInt64) {
        
        configuration = Realm.Configuration(schemaVersion: version, migrationBlock: { (_, oldVersion) in
            if oldVersion < version {
                 UserDefaults.standard.set(false, forKey: "isDataBaseUpdated")
                 self.configuration.deleteRealmIfMigrationNeeded = true
              
            }
        })
        
    }
    
    func updateOrCreateDB() {
        // Загрузка предварительно заполненной базы данных
        guard let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path else { return } //определяем путь до незаполненной базы данных
       
             if !FileManager.default.fileExists(atPath: defaultPath) {
                 do {
                    print("hello there")
                     //проверяем наличие файла по данному пути, в случае его отсутствия копируем туда предварительно заполненною базу данных
                     UserDefaults.standard.set(true, forKey: "isDataBaseUpdated")
                     try FileManager.default.copyItem(atPath: path, toPath: defaultPath)
                 } catch {
                     print("Error copying pre-populated Realm \(error)")
                 }
             }
             
             //Обновление уже сущещствующей у юзера базы данных
//             if !UserDefaults.standard.bool(forKey: "isDataBaseUpdated")  {
//                 do {
//                     UserDefaults.standard.set(true, forKey: "isDataBaseUpdated")
//                     try FileManager.default.removeItem(atPath: defaultPath)
//                     try FileManager.default.copyItem(atPath: path, toPath: defaultPath)
//                 } catch  {
//                     print("Error")
//                 }
//             }
//

            realmObject = try! Realm(configuration: configuration)
    }
}


