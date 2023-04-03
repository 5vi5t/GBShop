//
//  PayBasket.swift
//  OnlineShop
//
//  Created by Константин on 28.02.2023.
//

import Foundation
import Alamofire

class PayBasket: AbstractRequestFactory {
    // MARK: - Properties

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue

    // MARK: - Construction

    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = .global(qos: .utility)
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension PayBasket {
    struct PayBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "payBasket"
        let amount: Int
        let amountMethod: String
        var parameters: Parameters? {
            return [
                "amount": amount,
                "amount_method": amountMethod
            ]
        }
    }
}

extension PayBasket: PayBasketRequestFactory {
    // MARK: - Functions

    func payBasket(
        amount: Int,
        amountMethod: String,
        completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void
    ) {
        guard let baseUrl else { return }
        let requestModel = PayBasket(
            baseUrl: baseUrl,
            amount: amount,
            amountMethod: amountMethod)
        request(request: requestModel, completionHandler: completionHandler)
    }
}
