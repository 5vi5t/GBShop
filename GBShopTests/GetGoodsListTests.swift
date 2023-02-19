//
//  GetGoodsListTests.swift
//  GBShopTests
//
//  Created by Константин on 16.02.2023.
//

import XCTest
@testable import GBShop

final class GetGoodsListTests: XCTestCase {
    
    var requestFactory: RequestFactory!

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }
    
    func testGetGoodsListWithValidValues() {
        let pageNumber = 1
        let categoryId = 1
        let expectation = XCTestExpectation(description: #function)
        let getGoodsList = requestFactory.makeGetGoodsListRequestFactory()
        
        getGoodsList.getCatalogData(pageNumber: pageNumber, categoryId: categoryId) { response in
            switch response.result {
            case .success(let result):
                XCTAssertNotNil(result.pageNumber)
                XCTAssertNotNil(result.products)
                XCTAssertNil(result.result)
                XCTAssertNil(result.errorMessage)
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetGoodsListWithInvalidValues() {
        let pageNumber = 0
        let categoryId = 0
        let expectation = XCTestExpectation(description: #function)
        let getGoodsList = requestFactory.makeGetGoodsListRequestFactory()
        
        getGoodsList.getCatalogData(pageNumber: pageNumber, categoryId: categoryId) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(0, result.result)
                XCTAssertNil(result.products)
                XCTAssertNil(result.pageNumber)
                XCTAssertNotNil(result.errorMessage)
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
