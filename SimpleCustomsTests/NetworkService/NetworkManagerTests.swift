//
//  NetworkManagerTests.swift
//  SimpleCustomsTests
//
//  Created by Газияв Исхаков on 28.12.2019.
//  Copyright © 2019 Газияв Исхаков. All rights reserved.
//

import XCTest
@testable import SimpleCustoms

class NetworkManagerTests: XCTestCase {
    
    private var sut: NetworkManager!
    private var mockURLSession: MockURLSession!
    private var api: URL {
        get {
            guard let url = FullUrl.asia.fullUrlForCountries else { return URL(fileURLWithPath: "") }
            return url
        }
        
    }
    
    override func setUp() {
        super.setUp()
        sut = NetworkManager()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    
    func testSuccesfulCallReturnData() {
    
        sut.getData(url: api) { (result) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func testUnSuccessfulCallReturnsError() {
        guard let url = URL(string: "Foo") else {
            XCTFail()
            return }
        
        sut.getData(url: url) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    private func mockRequest(url: URL) -> URLComponents? {
        sut.urlSession = mockURLSession
        sut.getData(url: url) { _ in }
        
        return mockURLSession.urlComponents
    }
    
    func testNetworkCallUsesCorrectHost() {
        let urlComponents = mockRequest(url: api)
        XCTAssertEqual(urlComponents?.host, api.host)
    }
    
    func testNetworkCallUsesCorrectPath() {
        
        let urlComponents = mockRequest(url: api)
        XCTAssertEqual(urlComponents?.path, api.path)
    }
    
    func testNetworkCallUsesCorrectQuaryItems() {
        let urlPath = APIPath(scheme: "https", endpoint: "api.ratesapi.io", path: "/api/latest", params: ["base": "EUR",
            "symbols": "RUB"])
        
         guard let completeURL = urlPath.fullURL else { return }
        
        let urlComponents = mockRequest(url: completeURL)
       
        XCTAssertEqual(urlComponents?.percentEncodedQuery, completeURL.query)
        
    }
}



extension NetworkManagerTests {
    
    class MockURLSession: URLSessionProtocol {
        
        var url: URL?
        
        var urlComponents: URLComponents? {
            guard let url = url else { return nil }
            guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
            return urlComponents
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
    
}




