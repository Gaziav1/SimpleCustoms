//
//  RealmManager.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 24/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import Foundation
import RealmSwift



class RealmManager {
    
    private var database: Realm
    
    static let sharedInstance = RealmManager()
    
    private init() {
        database = try! Realm()
    }
   
    func getDataFromDB() -> Results<CustomsRules> {
        
        let results: Results<CustomsRules> = database.objects(CustomsRules.self)
        return results
   
    }
    
    public func filter(_ predicate: NSPredicate) -> Results<CustomsRules> {
        return database.objects(CustomsRules.self).filter(predicate)
    }
   
    func addData(object: CustomsRules) {
        
        try! database.write {
            database.add(object)
        }
    }
  
    func deleteFromDb(object: CustomsRules)   {
        try! database.write {
            database.delete(object)
        }
    }
}
