//
//  AbstractRequestFactory.swift
//  OnlineShop
//
//  Created by Константин on 10.02.2023.
//

import Foundation
import Alamofire

protocol AbstractRequestFactory {
    var errorParser: AbstractErrorParser { get }
    var sessionManager: Session { get }
    var queue: DispatchQueue { get }
    var baseUrl: URL? { get }
    
    @discardableResult
    func request<T: Decodable>(
        request: URLRequestConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    )
    -> DataRequest
}

extension AbstractRequestFactory {
    @discardableResult
    func request<T: Decodable>(
        request: URLRequestConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    )
    -> DataRequest {
        return sessionManager
            .request(request)
            .responseCodable(
                errorParser: errorParser,
                queue: queue,
                completionHandler: completionHandler
            )
    }
}

extension AbstractRequestFactory {
    var baseUrl: URL? {
        URL(string: "https://vaporapp-production.up.railway.app/")
    }
}
