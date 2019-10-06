//
//  NetworkManager.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 05/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private init(){}
    
    
    func makeRequest(url: URL, request: @escaping (Result<Data, Error>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                request(.failure(error!))
                return
            }
           
            request(.success(data!))
            
        }
        dataTask.resume()
    }
    
   
}
