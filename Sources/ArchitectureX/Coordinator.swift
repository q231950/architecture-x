import Foundation
import SwiftUI

/// The style a coordinator should be presented in when transitioning to it.
public enum PresentationStyle {
    case push
    case present(modalInPresentation: Bool)
    case fullscreenModal
    case replace
}

public protocol Coordinator: AnyObject {

    /// The type of the ``view`` of the ``Coordinator``.
    associatedtype ViewType: View

    /// The view representing this ``Coordinator``
    var view: ViewType { get }

    /// The navigator performs the transition of one ``Coordinator`` to another.
    var navigator: Navigator { get }
}

extension Coordinator {

    public func transition<C: Coordinator>(_ presentationStyle: PresentationStyle = .push, to: (Navigator) -> C) {
        switch presentationStyle {
        case .push: navigator.push(to(navigator))
        case .present(let isModalInPresentation):
            let navigationController = UINavigationController()
            navigationController.isModalInPresentation = isModalInPresentation

            let navigator = Navigator(navigationController: navigationController)
            self.navigator.present(to(navigator))
        case .fullscreenModal:
            let navigationController = UINavigationController()
            let navigator = Navigator(navigationController: navigationController)
            self.navigator.presentFullscreen(to(navigator))
        case .replace:
            navigator.set(to(navigator), animated: false)
        }
    }

    public func dismiss() {
        navigator.dismiss(self)
    }
}
