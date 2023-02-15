//
//  EditProfileTests.swift
//  GBShopTests
//
//  Created by Константин on 15.02.2023.
//

import XCTest
@testable import GBShop

final class EditProfileTests: XCTestCase {
    
    var requestFactory: RequestFactory!
    
    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }
    
    override func tearDownWithError() throws {
        requestFactory = nil
    }
    
    func test_editProfileWithValidValues() {
        let userId = 123
        let username = "Somebody"
        let password = "mypassword"
        let email = "some@some.ru"
        let gender = "m"
        let creditCard = "9872389-2424-234224-234"
        let bio = "This is good! I think I will switch to another language"
        let expectation = XCTestExpectation(description: #function)
        let editProfile = requestFactory.makeEditProfileRequestFactory()
        
        editProfile.changeUserData(userId: userId,
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
