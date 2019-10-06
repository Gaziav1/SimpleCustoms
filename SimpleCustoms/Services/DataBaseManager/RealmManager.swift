//
//  RealmManager.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 24/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation
import RealmSwift


import Foundation
import RealmSwift

let realmObject = try! Realm()

class RealmManager: NSObject {
    
    static let sharedInstance = RealmManager()
    
    func retrieveAllDataForObject(_ T : Object.Type) -> [Object] {
        
        var objects = [Object]()
        for result in realmObject.objects(T) {
            objects.append(result)
        }
        return objects
    }
    
    public func filter(_ predicate: NSPredicate, object: Object.Type) -> [Object] {
       var objects = [Object]()
        for result in realmObject.objects(object).filter(predicate) {
            objects.append(result)
        }
        return objects
    }
    
    func add(_ objects : [Object]) {
        
        try! realmObject.write{
            
            realmObject.add(objects)
        }
    }
    
    func delete(_ objects : [Object]) {
        
        try! realmObject.write{
            realmObject.delete(objects)
        }
    }
}


