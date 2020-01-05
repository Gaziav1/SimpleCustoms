//
//  NetworkManager.swift
//  SimpleCustoms
//
//  Created by Газияв Исхаков on 05/09/2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import UIKit

protocol Networking {
    func getData(url: URL, request: @escaping (Result<Data, Error>) -> Void)
}

protocol URLSessionProtocol {
     func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

class NetworkManager: Networking {

    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    func getData(url: URL, request: @escaping (Result<Data, Error>) -> Void) {
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                request(.failure(error!))
                return
            }
            request(.success(data!))
        }
        dataTask.resume()
    }
    
   
}

extension URLSession: URLSessionProtocol { }
