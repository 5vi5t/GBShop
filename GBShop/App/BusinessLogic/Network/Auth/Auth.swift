//
//  Auth.swift
//  GBShop
//
//  Created by Константин on 10.02.2023.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {
    
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

extension Auth: AuthRequestFactory {
    
    // MARK: - Functions
    
    func login(username: String, password: String, completionHandler: @escaping (Alamofire.AFDataResponse<LoginResult>) -> Void) {
        guard let baseUrl else { return }
        let requestModel = Login(baseUrl: baseUrl, login: username, password: password)
        request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "login.json"
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
}
