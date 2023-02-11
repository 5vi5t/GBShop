//
//  RegRequestFactory.swift
//  GBShop
//
//  Created by Константин on 11.02.2023.
//

import Foundation
import Alamofire

protocol RegRequestFactory {
    func registerUser(userId: Int,
                username: String,
                password: String,
                email: String,
                gender: String,
                creditCard: String,
                bio: String,
                completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void)
}
