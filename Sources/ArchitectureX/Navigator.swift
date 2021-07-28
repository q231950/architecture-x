import Foundation
import SwiftUI
import UIKit

public struct Navigator {

    public unowned let navigationController: UINavigationController

    public init(navigationController: UINavigationController, prefersLargeTitles: Bool = true) {
        self.navigationController = navigationController

        navigationController.navigationBar.prefersLargeTitles = prefersLargeTitles
    }

    func set<C: Coordinator>(_ coordinator: C, animated: Bool) {
        let hostedCoordinatorView = UIHostingController(rootView: coordinator.view)
        navigationController.setViewControllers([hostedCoordinatorView], animated: animated)
    }

    func push<C: Coordinator>(_ coordinator: C) {
        let hostedCoordinatorView = TitledHostingController(rootView: coordinator.view)
        navigationController.pushViewController(hostedCoordinatorView, animated: true)
    }

    func present<C: Coordinator>(_ coordinator: C) {
        let hostedCoordinatorView = UIHostingController(rootView: coordinator.view)
        coordinator.navigator.navigationController.setViewControllers([hostedCoordinatorView], animated: false)

        self.navigationController.present(coordinator.navigator.navigationController, animated: true, completion: nil)
    }

    func presentFullscreen<C: Coordinator>(_ coordinator: C) {
        let hostedCoordinatorView = UIHostingController(rootView: coordinator.view)
        coordinator.navigator.navigationController.setViewControllers([hostedCoordinatorView], animated: false)

        coordinator.navigator.navigationController.modalPresentationStyle = .fullScreen

        navigationController.present(coordinator.navigator.navigationController, animated: true)
    }

    func dismiss<C: Coordinator>(_ coordinator: C) {
        coordinator.navigator.navigationController.dismiss(animated: true, completion: nil)
    }
}

class TitledHostingController<T: View>: UIHostingController<T> {

    override func willMove(toParent parent: UIViewController?){
        super.willMove(toParent: parent)

        if parent == nil{
            self.navigationController?.isToolbarHidden = false
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let rootMirror = Mirror(reflecting: rootView)

        if let title = rootMirror.descendant("title") as? String {
            navigationItem.title = title
        }

        if let displayMode = rootMirror.descendant("displayMode") as? NavigationBarItem.TitleDisplayMode {
            navigationItem.largeTitleDisplayMode = displayMode.uikitDisplayMode
        }
    }
}

private extension NavigationBarItem.TitleDisplayMode {
    var uikitDisplayMode: UINavigationItem.LargeTitleDisplayMode {
        switch self {
        case .automatic: return .automatic
        case .inline: return .never
        case .large: return .always
        @unknown default: return .automatic
        }
    }
}
