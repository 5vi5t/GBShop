//
//  AuthTests.swift
//  OnlineShopTests
//
//  Created by Константин on 15.02.2023.
//

import XCTest
@testable import OnlineShop

final class AuthTests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var requestFactory: RequestFactory!

    // swiftlint:disable:next overridden_super_call
    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    // swiftlint:disable:next overridden_super_call
    override func tearDownWithError() throws {
        requestFactory = nil
    }
    
    func testLoginWithValidValues() {
        let username = "Somebody"
        let password = "mypassword"
        let expectation = XCTestExpectation(description: #function)
        let auth = requestFactory.makeAuthRequestFactory()
        
        auth.login(
            username: username,
            password: password
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(1, result.result)
                XCTAssertNotNil(result.user)
                XCTAssertNil(result.errorMessage)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoginWithInvalidValues() {
        let username = "u"
        let password = "qwerty"
        let expectation = XCTestExpectation(description: #function)
        let auth = requestFactory.makeAuthRequestFactory()
        
        auth.login(
            username: username,
            password: password
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(0, result.result)
                XCTAssertNotNil(result.errorMessage)
                XCTAssertNil(result.user)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
