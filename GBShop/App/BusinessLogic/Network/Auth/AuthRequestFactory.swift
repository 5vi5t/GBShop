//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Константин on 10.02.2023.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(username: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}
