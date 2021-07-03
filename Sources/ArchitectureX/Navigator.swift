import Foundation
import SwiftUI
import UIKit

public struct Navigator {

    public unowned let navigationController: UINavigationController

    public init(navigationController: UINavigationController, prefersLargeTitles: Bool = true) {
        self.navigationController = navigationController

        navigationController.navigationBar.prefersLargeTitles = prefersLargeTitles
    }

    func push<C: Coordinator>(_ coordinator: C) {
        let hostedCoordinatorView = UIHostingController(rootView: coordinator.view)
        navigationController.show(hostedCoordinatorView, sender: nil)
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
