import SwiftUI

public protocol Mediatable: ObservableObject {
    /// A type that defines the capabilities of the mediator.
    associatedtype Capabilities

    /// The input of the mediator from the view.
    associatedtype Input

    /// The type used as the content of the view.
    associatedtype Content

    var capabilities: Capabilities { get set }
    var input: Input { get set }
    var content: Content { get }

    func binding<Value>(_ keyPath: WritableKeyPath<Input, Value>) -> Binding<Value>
}

public extension Mediatable {
    /// Returns a view with the specified content handler.
    ///
    /// - Parameter contentHandler: The closure to use to create the view content.
    ///
    /// - Returns: A view with the specified content.
    func view(@ViewBuilder content contentHandler: (Content) -> some View) -> some View {
        contentHandler(content)
    }

    /// Returns a binding for the specified key path of the Input.
    ///
    /// - Parameter keyPath: The key path to create a binding for.
    ///
    /// - Returns: A binding for the specified key path.
    func binding<Value>(_ keyPath: WritableKeyPath<Input, Value>) -> Binding<Value> {
        Binding(
            get: { self.input[keyPath: keyPath] },
            set: { newValue in
                DispatchQueue.main.async { [weak self] in
                    self?.input[keyPath: keyPath] = newValue
                }
            }
        )
    }
}
