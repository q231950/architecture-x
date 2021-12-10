import Foundation
import SwiftUI

extension View {
    func coordinated<C: Coordinator>(coordinator: C) -> some View {
        modifier(ViewCoordinator(router: coordinator.router ?? Router()))
    }

    public var containInNavigation: some View {
        modifier(ViewNavigationContainer())
    }
}

struct ViewNavigationContainer: ViewModifier {

    func body(content: Content) -> some View {
        NavigationView {
            content
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ViewCoordinator: ViewModifier {
    @ObservedObject var router: Router

    /// Hiding the navigation bar is possible with view modifiers:
    /// ```swift
    /// Button("present") {
    ///   viewModel.presentContentB()
    /// }
    /// .navigationBarTitle("")
    /// .navigationBarHidden(true)
    /// ```
    ///
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $router.showingFullscreenModal) {
                router.fullscreenModal
            }
            .sheet(isPresented: $router.showingSheet) {
                router.sheet
            }
        NavigationLink(isActive: $router.isNavigationLinkActive) {
            router.navigationLinkDestination
        } label: {
            // nothing since this is provided by the initiator of the navigation link
        }
    }
}

public struct NavigationLinkDestination<ViewType: View> {
    var view: ViewType
}
