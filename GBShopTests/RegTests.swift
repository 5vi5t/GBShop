//
//  RegTests.swift
//  GBShopTests
//
//  Created by Константин on 15.02.2023.
//

import XCTest
@testable import GBShop

final class RegTests: XCTestCase {
    
    var requestFactory: RequestFactory!
    
    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }
    
    override func tearDownWithError() throws {
        requestFactory = nil
    }
    
    func testRegWithValidValues() {
        let userId = 123
        let username = "Somebody"
        let password = "mypassword"
        let email = "some@some.ru"
        let gender = "m"
        let creditCard = "9872389-2424-234224-234"
        let bio = "This is good! I think I will switch to another language"
        let expectation = XCTestExpectation(description: #function)
        let reg = requestFactory.makeRegRequestFactory()
        
        reg.registerUser(userId: userId,
                         username: username,
                         password: password,
                         email: email,
                         gender: gender,
                         creditCard: creditCard,
                         bio: bio) { response in
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
