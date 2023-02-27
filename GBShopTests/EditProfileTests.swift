//
//  EditProfileTests.swift
//  GBShopTests
//
//  Created by Константин on 15.02.2023.
//

import XCTest
@testable import GBShop

final class EditProfileTests: XCTestCase {
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
    
    func testEditProfileWithValidValues() {
        let userId = 123
        let username = "Somebody"
        let password = "mypassword"
        let email = "some@some.ru"
        let gender = "m"
        let creditCard = "9872389-2424-234224-234"
        let bio = "This is good! I think I will switch to another language"
        let expectation = XCTestExpectation(description: #function)
        let editProfile = requestFactory.makeEditProfileRequestFactory()
        
        editProfile.changeUserData(
            userId: userId,
            username: username,
            password: password,
            email: email,
            gender: gender,
            creditCard: creditCard,
            bio: bio
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(1, result.result)
                XCTAssertNil(result.errorMessage)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testEditProfileWithInvalidValues() {
        let userId = 1
        let username = "Somebody"
        let password = "qwerty"
        let email = "some"
        let gender = "m"
        let creditCard = ""
        let bio = "This is good! I think I will switch to another language"
        let expectation = XCTestExpectation(description: #function)
        let editProfile = requestFactory.makeEditProfileRequestFactory()
        
        editProfile.changeUserData(
            userId: userId,
            username: username,
            password: password,
            email: email,
            gender: gender,
            creditCard: creditCard,
            bio: bio
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(0, result.result)
                XCTAssertNotNil(result.errorMessage)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
