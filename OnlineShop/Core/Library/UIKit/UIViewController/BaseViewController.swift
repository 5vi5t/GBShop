import UIKit

class BaseViewController<View: UIView>: UIViewController {
    typealias OnBackButtonTap = () -> Void

    // MARK: - Properties
    // swiftlint:disable:next force_cast
    var rootView: View { view as! View }
    var onBackButtonTap: OnBackButtonTap?

    // MARK: - Lifecycle
    override func loadView() {
        view = View.loadView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            onBackButtonTap?()
        }
    }
}
