//
//  ShowcaseCoordinator.swift
//  OnlineShop
//
//  Created by Константин on 10.04.2023.
//

import Foundation

final class ShowcaseCoordinator: BaseCoordinator {
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
        showShowcase()
    }

    private func showShowcase() {
        let showcaseScreen = screenFactory.makeShowcaseScreen()
        router.setRootModule(showcaseScreen)
    }
}
