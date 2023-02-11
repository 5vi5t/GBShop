//
//  Deauth.swift
//  GBShop
//
//  Created by Константин on 11.02.2023.
//

import Foundation
import Alamofire

class Deauth: AbstractRequestFactory {
    
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

extension Deauth {
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        let userId: Int
        var parameters: Parameters? {
            return ["id_user": userId]
        }
    }
}

extension Deauth: DeauthRequestFactory {
    
    // MARK: - Functions
    
    func logout(userId: Int,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        guard let baseUrl else { return }
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        request(request: requestModel, completionHandler: completionHandler)
    }
}
