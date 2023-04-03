//
//  RegRequestFactory.swift
//  OnlineShop
//
//  Created by Константин on 11.02.2023.
//

import Foundation
import Alamofire

protocol RegRequestFactory {
    func registerUser(
        model: RegisterUserModel,
        completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void
    )
}
