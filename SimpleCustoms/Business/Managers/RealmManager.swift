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
                return "" }
            return specificPath
        }
    }
    static let sharedInstance = RealmManager()
    
    func retrieveAllDataForObject<T: Object>(_ element: T.Type) -> Results<T> {
        guard let realm = realmObject else { fatalError("Unable to create realm instance") }
        return realm.objects(element)
    }
    
    
    func add<T: Object>(_ objects: [T]) {
        
        guard let realm = realmObject else { return }
        
        try! realm.write {
            realm.add(objects)
        }
    }
    
    func update(_ block: @escaping ()-> Void) {
        
        guard let realm = realmObject else { return }
        try! realm.write(block)
    }
    
    func delete<T: Object>(_ objects : [T]) {
        
        guard let realm = realmObject else { return }
        
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    func filter<T: Object>(_ predicate: NSPredicate, object: T.Type) -> Results<T>? {
    
          guard let realm = realmObject else { return nil }
          let result = realm.objects(object).filter(predicate)
          return result
      }
    
    func realmMigrateIfNeeded(to version: UInt64) {
        
        let config = Realm.Configuration(schemaVersion: version, migrationBlock: { (migration, oldVersion) in
            if oldVersion < version {
                
            }
        })
        
        Realm.Configuration.defaultConfiguration = config
        openRealm()
        realmObject = try! Realm()
    }
    
    private func openRealm() {
        let bundlePath = Bundle.main.path(forResource: "default", ofType: "realm")!
        guard let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path else { return }
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: defaultPath) {
            print("use pre-populated database")
            do {
                UserDefaults.standard.set(true, forKey: "isDataBaseUpdated")
                try fileManager.copyItem(atPath: bundlePath, toPath: defaultPath)
                print("Copied")
            } catch {
                print("error")
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

