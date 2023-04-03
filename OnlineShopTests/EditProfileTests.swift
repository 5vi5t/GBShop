//
//  EditProfileTests.swift
//  OnlineShopTests
//
//  Created by Константин on 15.02.2023.
//

import XCTest
@testable import OnlineShop

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
        let model = ChangeUserDataModel(
            userId: 123,
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            gender: "m",
            creditCard: "9872389-2424-234224-234",
            bio: "This is good! I think I will switch to another language")
        let expectation = XCTestExpectation(description: #function)
        let editProfile = requestFactory.makeEditProfileRequestFactory()
        
        editProfile.changeUserData(model: model) { response in
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
        let model = ChangeUserDataModel(
            userId: 1,
            username: "Somebody",
            password: "qwerty",
            email: "some",
            gender: "m",
            creditCard: "",
            bio: "This is good! I think I will switch to another language")
        let expectation = XCTestExpectation(description: #function)
        let editProfile = requestFactory.makeEditProfileRequestFactory()
        
        editProfile.changeUserData(model: model) { response in
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
