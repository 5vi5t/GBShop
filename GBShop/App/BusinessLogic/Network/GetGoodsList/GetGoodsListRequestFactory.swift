//
//  GetGoodsListRequestFactory.swift
//  GBShop
//
//  Created by Константин on 16.02.2023.
//

import Foundation
import Alamofire

protocol GetGoodsListRequestFactory {
    func getCatalogData(
        pageNumber: Int,
        categoryId: Int,
        completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void
    )
}
