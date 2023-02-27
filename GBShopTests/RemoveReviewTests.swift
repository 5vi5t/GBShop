//
//  RemoveReviewTests.swift
//  GBShopTests
//
//  Created by Константин on 23.02.2023.
//

import XCTest
@testable import GBShop

final class RemoveReviewTests: XCTestCase {
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

    func testRemoveReviewWithValidValues() {
        let commentId = 123
        let expectation = XCTestExpectation(description: #function)
        let removeReview = requestFactory.makeRemoveReviewRequestFactory()

        removeReview.removeReview(commentId: commentId) { response in
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

    func testRemoveReviewWithInvalidValues() {
        let commentId = 1
        let expectation = XCTestExpectation(description: #function)
        let removeReview = requestFactory.makeRemoveReviewRequestFactory()

        removeReview.removeReview(commentId: commentId) { response in
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
