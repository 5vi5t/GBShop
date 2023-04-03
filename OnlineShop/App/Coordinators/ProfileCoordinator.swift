//
//  ProfileCoordinator.swift
//  OnlineShop
//
//  Created by Константин on 28.03.2023.
//

import Foundation

final class ProfileCoordinator: BaseCoordinator {
    // MARK: - Properties
    var finishFlow: VoidClosure?

    private let screenFactory: ScreenFactory
    private let router: Router

    // MARK: - Construction
    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }

    // MARK: - Function
    override func start() {
        showProfile()
    }

    private func showProfile() {
        let profileScreen = screenFactory.makeProfileScreen()
        profileScreen.onEditProfile = { [weak self] in self?.finishFlow?() }
        router.setRootModule(profileScreen)
    }
}
