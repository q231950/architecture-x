import Foundation
import SwiftUI

/// This is the protocol every  Coordinator has to conform to.
///
/// A proto-typical ``Coordinator`` looks like this:
///
/// ```swift
/// class MyCoordinator: Coordinator {
///     var router: Router?
///
///     var contentView: some View {
///         Text("abc")
///     }
/// }
/// ```
///
public protocol Coordinator: AnyObject {
    associatedtype ViewType: View

    var contentView: ViewType { get }
    var router: Router? { get set }
}

/// some more
extension Coordinator {

    /// The view of a Coordinator.
    ///
    /// This only needs to be exposed publicly as there is not MainCoordinator.
    public var view: some View {
        contentView
            .coordinated(coordinator: self)
    }

    /// Transition from one Coordinator to another.
    ///
    /// - Parameters:
    ///     - child: The child coordinator to transition to
    ///     - style: The style how the child Coordinator should be added to the scene
    public func transition<C: Coordinator>(to child: C, style: PresentationStyle) {

        child.router = Router(parent: router)

        switch style {
        case .push:
            router?.navigationLinkDestination = AnyView(child.view)
            router?.isNavigationLinkActive = true
        case .present(let isModalInPresentation):
            router?.sheet = AnyView(child.view.containInNavigation)
            router?.showingSheet = true
            break
        case .fullscreenModal:
            router?.fullscreenModal = AnyView(child.view.containInNavigation)
            router?.showingFullscreenModal = true
            break
        }
    }

    /// Dismisses a modal sheet or fullscreen modal that is currently presented.
    public func dismiss() {
        router?.parent?.showingSheet = false
        router?.parent?.showingFullscreenModal = false
    }

    /// Pops a view that was navigated to.
    public func pop() {
        router?.parent?.isNavigationLinkActive = false
    }
}
