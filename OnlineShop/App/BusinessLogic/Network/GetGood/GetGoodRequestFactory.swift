//
//  GetGoodRequestFactory.swift
//  OnlineShop
//
//  Created by Константин on 16.02.2023.
//

import Foundation
import Alamofire

protocol GetGoodRequestFactory {
    func getGood(
        by id: Int,
        completionHandler: @escaping (AFDataResponse<GetGoodByIdResult>) -> Void
    )
}
