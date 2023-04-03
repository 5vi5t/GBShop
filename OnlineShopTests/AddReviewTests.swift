//
//  AddReviewTests.swift
//  OnlineShopTests
//
//  Created by Константин on 23.02.2023.
//

import XCTest
@testable import OnlineShop

final class AddReviewTests: XCTestCase {
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

    func testAddReviewWithValidValues() {
        let userId = 123
        let text = "Текст отзыва"
        let expectation = XCTestExpectation(description: #function)
        let addReview = requestFactory.makeAddReviewRequestFactory()

        addReview.addReview(
            userId: userId,
            text: text
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(1, result.result)
                XCTAssertNotNil(result.userMessage)
                XCTAssertNil(result.errorMessage)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testAddReviewWithInvalidValues() {
        let userId = 1
        let text = ""
        let expectation = XCTestExpectation(description: #function)
        let addReview = requestFactory.makeAddReviewRequestFactory()

        addReview.addReview(
            userId: userId,
            text: text
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(0, result.result)
                XCTAssertNil(result.userMessage)
                XCTAssertNotNil(result.errorMessage)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
