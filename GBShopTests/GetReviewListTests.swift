//
//  GetReviewListTests.swift
//  GBShopTests
//
//  Created by Константин on 23.02.2023.
//

import XCTest
@testable import GBShop

final class GetReviewListTests: XCTestCase {
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

    func testGetReviewListWithValidValues() {
        let pageNumber = 1
        let productId = 123
        let expectation = XCTestExpectation(description: #function)
        let getReviewList = requestFactory.makeGetReviewListRequestFactory()

        getReviewList.getReviewList(
            pageNumber: pageNumber,
            productId: productId
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(1, result.result)
                XCTAssertNotNil(result.pageNumber)
                XCTAssertNotNil(result.reviews)
                XCTAssertNil(result.errorMessage)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testGetReviewListWithInvalidValues() {
        let pageNumber = 0
        let productId = 1
        let expectation = XCTestExpectation(description: #function)
        let getReviewList = requestFactory.makeGetReviewListRequestFactory()

        getReviewList.getReviewList(
            pageNumber: pageNumber,
            productId: productId
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(0, result.result)
                XCTAssertNil(result.pageNumber)
                XCTAssertNil(result.reviews)
                XCTAssertNotNil(result.errorMessage)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
