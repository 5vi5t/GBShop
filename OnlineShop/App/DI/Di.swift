import UIKit
import Alamofire

final class Di {
    // MARK: - Properties
    fileprivate let screenFactory: ScreenFactoryImpl
    fileprivate let coordinatorFactory: CoordinatorFactoryImpl
    fileprivate let requestFactory: RequestFactory

    // MARK: - Construction
    init() {
        screenFactory = ScreenFactoryImpl()
        coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
        requestFactory = RequestFactory()

        screenFactory.di = self
    }
}

protocol AppFactory {
    func makeKeyWindowWithCoordinator(scene: UIScene) -> (UIWindow, Coordinator)
}

// MARK: - AppFactory
extension Di: AppFactory {
    func makeKeyWindowWithCoordinator(scene: UIScene) -> (UIWindow, Coordinator) {
        guard let windowScene = scene as? UIWindowScene else {
            fatalError("no windowScene")
        }
        let window = UIWindow(windowScene: windowScene)
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = true
        let router = RouterImpl(rootController: rootVC)
        let coordinator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, coordinator)
    }
}

protocol ScreenFactory {
    func makeAuthScreen() -> AuthController<AuthViewImpl>
    func makeRegScreen() -> RegController<RegViewImpl>
    func makeProfileScreen() -> ProfileController<ProfileViewImpl>
}

final class ScreenFactoryImpl: ScreenFactory {
    // MARK: - Properties
    // swiftlint:disable:next implicitly_unwrapped_optional
    fileprivate weak var di: Di!

    // MARK: - Construction
    fileprivate init() {}

    // MARK: - Functions
    func makeAuthScreen() -> AuthController<AuthViewImpl> {
        AuthController<AuthViewImpl>(requestFactory: di.requestFactory)
    }

    func makeRegScreen() -> RegController<RegViewImpl> {
        RegController<RegViewImpl>(requestFactory: di.requestFactory)
    }

    func makeProfileScreen() -> ProfileController<ProfileViewImpl> {
        ProfileController(requestFactory: di.requestFactory)
    }
}

protocol CoordinatorFactory {
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator
    func makeAuthCoordinator(router: Router) -> AuthCoordinator
    func makeProfileCoordinator(router: Router) -> ProfileCoordinator
}

final class CoordinatorFactoryImpl: CoordinatorFactory {
    // MARK: - Properties
    private let screenFactory: ScreenFactory

    // MARK: - Construction
    fileprivate init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }

    // MARK: - Functions
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator {
        return ApplicationCoordinator(router: router, coordinatorFactory: self)
    }

    func makeAuthCoordinator(router: Router) -> AuthCoordinator {
        return AuthCoordinator(router: router, screenFactory: screenFactory)
    }

    func makeProfileCoordinator(router: Router) -> ProfileCoordinator {
        return ProfileCoordinator(router: router, screenFactory: screenFactory)
    }
}
