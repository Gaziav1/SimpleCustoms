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
    
    private var path: String {
        get {
            guard let specificPath = Bundle.main.path(forResource: "default", ofType: "realm") else {
                print("cock sucker")
                return "" }
            print(specificPath)
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
        
        let config = Realm.Configuration(schemaVersion: version, migrationBlock: { (migration, oldVersion) in
            if oldVersion < version {
                //UserDefaults.standard.set(true, forKey: <#T##String#>)
                //                migration.renameProperty(onType: "CustomsRules", from: "forCountryCode", to: "countryName"
    
            }
        })
        
        Realm.Configuration.defaultConfiguration = config
        openRealm()
        realmObject = try! Realm()
    }
    
    func openRealm() {
        let bundlePath = Bundle.main.path(forResource: "default", ofType: "realm")!
        guard let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path else { return }
        let fileManager = FileManager.default
     
        // Only need to copy the prepopulated `.realm` file if it doesn't exist yet
        if !fileManager.fileExists(atPath: defaultPath) {
            print("use pre-populated database")
            do {
                UserDefaults.standard.set(true, forKey: "isDataBaseUpdated")
                try fileManager.copyItem(atPath: bundlePath, toPath: defaultPath)
                print("Copied")
            } catch {
                print(error)
            }
        }
        
        if !UserDefaults.standard.bool(forKey: "isDataBaseUpdated") {
            do {
        
                UserDefaults.standard.set(true, forKey: "isDataBaseUpdated")
                try fileManager.removeItem(atPath: defaultPath)
                try fileManager.copyItem(atPath: bundlePath, toPath: defaultPath)
            } catch {
                print(error)
            }
        }
    }
}

