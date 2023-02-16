//
//  GetGood.swift
//  GBShop
//
//  Created by Константин on 16.02.2023.
//

import Foundation
import Alamofire

class GetGood: AbstractRequestFactory {
    
    // MARK: - Properties
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")
    
    // MARK: - Construction
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = .global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GetGood {
    struct GoodById: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getGoodById.json"
        let productId: Int
        var parameters: Parameters? {
            return [
                "id_product" : productId
            ]
        }
    }
}

extension GetGood: GetGoodRequestFactory {
    
    // MARK: - Functions
    
    func getGood(by id: Int,
                 completionHandler: @escaping (AFDataResponse<GetGoodByIdResult>) -> Void) {
        guard let baseUrl else { return }
        let requestModel = GoodById(baseUrl: baseUrl,
                                    productId: id)
        request(request: requestModel, completionHandler: completionHandler)
    }
}
