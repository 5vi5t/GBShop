//
//  GetGoodsList.swift
//  GBShop
//
//  Created by Константин on 16.02.2023.
//

import Foundation
import Alamofire

class GetGoodsList: AbstractRequestFactory {
    
    // MARK: - Properties
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    
    // MARK: - Construction
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = .global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GetGoodsList {
    struct CatalogData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "catalogData"
        let pageNumber: Int
        let categoryId: Int
        var parameters: Parameters? {
            return [
                "page_number" : pageNumber,
                "id_category" : categoryId
            ]
        }
    }
}

extension GetGoodsList: GetGoodsListRequestFactory {
    
    // MARK: - Functions
    
    func getCatalogData(pageNumber: Int,
                        categoryId: Int,
                        completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void) {
        guard let baseUrl else { return }
        let requestModel = CatalogData(baseUrl: baseUrl,
                                       pageNumber: pageNumber,
                                       categoryId: categoryId)
        request(request: requestModel, completionHandler: completionHandler)
    }
}
