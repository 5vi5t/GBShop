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
        model: ChangeUserDataModel,
        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void
    )
}
