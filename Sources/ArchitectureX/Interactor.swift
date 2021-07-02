public protocol Interactor {
    associatedtype C: Coordinator
    var coordinator: C  { get }
}
