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
    
    static let sharedInstance = RealmManager()
    
    func retrieveAllDataForObject(_ T : Object.Type) -> [Object] {
        
        var objects = [Object]()
        guard let realm = realmObject else { return objects }
        for result in realm.objects(T) {
            objects.append(result)
        }
        return objects
    }
    
    public func filter(_ predicate: NSPredicate, object: Object.Type) -> [Object] {
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
}


