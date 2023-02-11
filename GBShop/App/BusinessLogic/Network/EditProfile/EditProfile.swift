//
//  EditProfile.swift
//  GBShop
//
//  Created by Константин on 11.02.2023.
//

import Foundation
import Alamofire

class EditProfile: AbstractRequestFactory {
    
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

extension EditProfile {
    struct ChangeUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        let userId: Int
        let login: String
        let password: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        var parameters: Parameters? {
            return [
                "id_user" : userId,
                "username" : login,
                "password" : password,
                "email" : email,
                "gender": gender,
                "credit_card" : creditCard,
                "bio" : bio
            ]
        }
    }
}

extension EditProfile: EditProfileRequestFactory {
    
    // MARK: - Functions
    
    func changeUserData(
        userId: Int,
        username: String,
        password: String,
        email: String,
        gender: String,
        creditCard: String,
        bio: String,
        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
            guard let baseUrl else { return }
            let requestModel = ChangeUserData(baseUrl: baseUrl,
                                              userId: userId,
                                              login: username,
                                              password: password,
                                              email: email,
                                              gender: gender,
                                              creditCard: creditCard,
                                              bio: bio)
            request(request: requestModel, completionHandler: completionHandler)
        }
}
