//
//  AuthTests.swift
//  GBShopTests
//
//  Created by Константин on 15.02.2023.
//

import XCTest
@testable import GBShop

final class AuthTests: XCTestCase {
    
    var requestFactory: RequestFactory!

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }
    
    func testLoginWithValidValues() {
        let username = "Somebody"
        let password = "mypassword"
        let expectation = XCTestExpectation(description: #function)
        let auth = requestFactory.makeAuthRequestFactory()
        
        auth.login(username: username,
                     password: password) { response in
            switch response.result {
            case .success(_): break
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
