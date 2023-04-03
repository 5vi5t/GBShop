import UIKit

final class ContainerViewController: UIViewController {
    // MARK: - Properties
    private let rootView: UIView

    // MARK: - Construction
    init(rootView: UIView) {
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    override func loadView() {
        view = rootView
    }
}
