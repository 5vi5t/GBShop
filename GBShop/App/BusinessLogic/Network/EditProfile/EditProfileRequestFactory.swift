//
//  EditProfileRequestFactory.swift
//  GBShop
//
//  Created by Константин on 11.02.2023.
//

import Foundation
import Alamofire

protocol EditProfileRequestFactory {
    func changeUserData(
        userId: Int,
        username: String,
        password: String,
        email: String,
        gender: String,
        creditCard: String,
        bio: String,
        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}
