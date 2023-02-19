//
//  GetGoodTests.swift
//  GBShopTests
//
//  Created by Константин on 16.02.2023.
//

import XCTest
@testable import GBShop

final class GetGoodTests: XCTestCase {
    
    var requestFactory: RequestFactory!

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }
    
    func testGetGoodWithValidValues() {
        let id = 123
        let expectation = XCTestExpectation(description: #function)
        let getGood = requestFactory.makeGetGoodRequestFactory()
        
        getGood.getGood(by: id) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(1, result.result)
                XCTAssertNotNil(result.productName)
                XCTAssertNotNil(result.productPrice)
                XCTAssertNotNil(result.productDescription)
                XCTAssertNil(result.errorMessage)
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetGoodWithInvalidValues() {
        let id = 1
        let expectation = XCTestExpectation(description: #function)
        let getGood = requestFactory.makeGetGoodRequestFactory()
        
        getGood.getGood(by: id) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(0, result.result)
                XCTAssertNil(result.productName)
                XCTAssertNil(result.productPrice)
                XCTAssertNil(result.productDescription)
                XCTAssertNotNil(result.errorMessage)
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
