import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Properties
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    private var isLogin = false

    // MARK: - Construction
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }

    // MARK: - Function
    override func start() {
        if isLogin {
            //            runMovieFlow()
        } else {
            runAuthFlow()
        }
    }

    private func runAuthFlow() {
        let coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.isLogin = true
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}
