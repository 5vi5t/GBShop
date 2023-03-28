//
//  ProfileController.swift
//  GBShop
//
//  Created by Константин on 28.03.2023.
//

import UIKit

final class ProfileController<View: ProfileView>: BaseViewController<View> {
    // MARK: - Properties
    private let editProfile: EditProfileRequestFactory
    
    // MARK: - Construction
    init(requestFactory: RequestFactory) {
        self.editProfile = requestFactory.makeEditProfileRequestFactory()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
