//
//  ResponseCodableTests.swift
//  GBShopTests
//
//  Created by Константин on 14.02.2023.
//

import XCTest
import Alamofire
@testable import GBShop

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum ApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

final class ResponseCodableTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://failUrl")
    var errorParser: ErrorParserStub!
    
    override func setUpWithError() throws {
        errorParser = ErrorParserStub()
    }
    
    override func tearDownWithError() throws {
        errorParser = nil
    }
    
    func test_shouldDownloadAndParse() {
        AF.request("https://jsonplaceholder.typicode.com/posts/1")
            .responseCodable(errorParser: errorParser) { [weak self] (response: DataResponse<PostStub, AFError>) in
                switch response.result {
                case .success(_):
                    self?.expectation.fulfill()
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
