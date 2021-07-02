import Foundation
import SwiftUI
import UIKit

public struct ViewControllerContainer: UIViewControllerRepresentable {

    let viewController: UIViewController
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        viewController
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
