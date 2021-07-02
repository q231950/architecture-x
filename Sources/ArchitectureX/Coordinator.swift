import Foundation
import SwiftUI

public protocol Coordinator: AnyObject {

    /// The type of the ``view`` of the ``Coordinator``.
    associatedtype ViewType: View

    /// The view representing this ``Coordinator``
    var view: ViewType { get }

    /// The navigator performs the transition of one ``Coordinator`` to another.
    var navigator: Navigator { get }
}

/// The style a coordinator should be presented in when transitioning to it.
public enum PresentationStyle {
    case push
    case present(modalInPresentation: Bool)
    case fullscreenModal
}
