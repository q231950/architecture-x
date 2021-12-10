import Foundation
import SwiftUI

/// Holds the information the state of a view routing to another view
public class Router: ObservableObject {

    /// The parent ``Router``. This property is used to dismiss or ``Coordinator/pop()``
    unowned var parent: Router?

    @Published var showingSheet = false
    var sheet: AnyView = AnyView(EmptyView())

    @Published var showingFullscreenModal = false
    var fullscreenModal: AnyView = AnyView(EmptyView())

    @Published var isNavigationLinkActive = false
    var navigationLinkDestination: AnyView = AnyView(EmptyView())

    public init() {}

    /// Initialize a Router with a given parent.
    /// - Parameter parent: The parent of the new ``Router``
    init(parent: Router? = nil) {
        self.parent = parent
    }
}
