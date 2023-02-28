//
//  DeleteFromBasket.swift
//  GBShop
//
//  Created by Константин on 28.02.2023.
//

import Foundation
import Alamofire

class DeleteFromBasket: AbstractRequestFactory {
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

extension DeleteFromBasket {
    struct DeleteFromBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteFromBasket"
        let productId: Int
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
}

extension DeleteFromBasket: DeleteFromBasketRequestFactory {
    // MARK: - Functions

    func deleteFromBasket(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void
    ) {
        guard let baseUrl else { return }
        let requestModel = DeleteFromBasket(
            baseUrl: baseUrl,
            productId: productId)
        request(request: requestModel, completionHandler: completionHandler)
    }
}
