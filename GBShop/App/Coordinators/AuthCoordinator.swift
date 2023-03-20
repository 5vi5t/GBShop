import Foundation

final class AuthCoordinator: BaseCoordinator {
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
        showAuth()
    }

    private func showAuth() {
        let authScreen = screenFactory.makeAuthScreen()
        authScreen.onLogin = { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(authScreen, hideBar: true)
    }
}
