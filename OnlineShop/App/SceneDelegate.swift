//
//  SceneDelegate.swift
//  OnlineShop
//
//  Created by Константин on 08.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    private let appFactory: AppFactory = Di()
    private var appCoordinator: Coordinator?
    var window: UIWindow?

    // MARK: - Functions
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        runUI(scene: scene)
    }

    private func runUI(scene: UIScene) {
        let (window, coordinator) = appFactory.makeKeyWindowWithCoordinator(scene: scene)
        self.window = window
        self.appCoordinator = coordinator

        window.makeKeyAndVisible()
        coordinator.start()
    }
}
