//
//  AddToBasket.swift
//  GBShop
//
//  Created by Константин on 28.02.2023.
//

import Foundation
import Alamofire

class AddToBasket: AbstractRequestFactory {
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

extension AddToBasket {
    struct AddToBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addToBasket"
        let productId: Int
        let quantity: Int
        var parameters: Parameters? {
            return [
                "id_product": productId,
                "quantity": quantity
            ]
        }
    }
}

extension AddToBasket: AddToBasketRequestFactory {
    // MARK: - Functions

    func addToBasket(
        productId: Int,
        quantity: Int,
        completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void
    ) {
        guard let baseUrl else { return }
        let requestModel = AddToBasket(
            baseUrl: baseUrl,
            productId: productId,
            quantity: quantity)
        request(request: requestModel, completionHandler: completionHandler)
    }
}
