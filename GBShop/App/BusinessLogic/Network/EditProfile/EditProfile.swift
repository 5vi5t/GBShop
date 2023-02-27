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
    
    // MARK: - Construction
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = .global(qos: .utility)
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension EditProfile {
    struct ChangeUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "changeUserData"
        let userId: Int
        let login: String
        let password: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "username": login,
                "password": password,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio
            ]
        }
    }
}

extension EditProfile: EditProfileRequestFactory {
    // MARK: - Functions

    func changeUserData(
        model: ChangeUserDataModel,
        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void
    ) {
        guard let baseUrl else { return }
        let requestModel = ChangeUserData(
            baseUrl: baseUrl,
            userId: model.userId,
            login: model.username,
            password: model.password,
            email: model.email,
            gender: model.gender,
            creditCard: model.creditCard,
            bio: model.bio)
        request(request: requestModel, completionHandler: completionHandler)
    }
}
