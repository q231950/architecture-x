import Foundation

/// The style a ``Coordinator`` should be presented in when transitioning to it.
public enum PresentationStyle {
    /// Pushes a view onto the navigation stack
    case push
    /// Presents a view in two variants. Either with the option to be capable of being dismissed by pulling down or not to
    case present(modalInPresentation: Bool)
    /// Presents a view as a fullscreen modal
    case fullscreenModal
}
