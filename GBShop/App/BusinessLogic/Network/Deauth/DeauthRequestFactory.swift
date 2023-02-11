//
//  DeauthRequestFactory.swift
//  GBShop
//
//  Created by Константин on 10.02.2023.
//

import Foundation
import Alamofire

protocol DeauthRequestFactory {
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}
