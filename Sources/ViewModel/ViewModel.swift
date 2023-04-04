import SwiftUI

/**
 A base class for creating view models in SwiftUI.

 A view model is responsible for managing the state and behavior of a view. The view model can provide bindings to the view
 for updating its state, and can also provide methods for performing actions and making decisions based on user input or other
 events.

 To create a view model, subclass ViewModel and implement the content property with the content for the view. You can also
 provide additional properties and methods to manage the state and behavior of the view.

 - `Capabilities`: A type that defines the capabilities of the view model.
 - `Input`: The input of the view model from the view.
 - `Content`: The content data used by the view.

 Example usage:

 ```swift
 class MyViewModel: ViewModel<MyCapabilities, MyInput, MyContent> {
     @Published private var title: String = "My View"

     override var content: MyContent {
        MyContent(title: title)
    }

    func handleTap() {
        // Handle user tap here
    }
 }
 ```

  The `ViewModel` class provides the following:

  - `capabilities`: A property that holds the capabilities of the view model.
  - `input`: A published property that holds the input of the view model from the view.
  - `content`: An open computed property that must be implemented by the subclass to provide the content of the view.
  - `view`: A method that returns a view with the specified content handler.
  - `binding`: A method that returns a binding for the specified key path of the input.

  Usage:

  - Create a subclass of `ViewModel` with `Capabilities`, `Input`, and `Content` types.
  - Implement the `content` property with the content for the view.
  - Optionally, provide additional properties and methods to manage the state and behavior of the view.
  - Use the `view` method to return a view with the specified content.
  - Use the `binding` method to return a binding for the specified key path of the input.
*/
open class ViewModel<Capabilities, Input, Content>: Mediatable {
    /// A type that defines the capabilities of the view model.
    public var capabilities: Capabilities

    /// The input of the view model from the view.
    @Published open var input: Input

    /// This property must be implemented by the subclass and will be used as the content of the view.
    open var content: Content {
        fatalError("\(Self.self) must implement content")
    }

    /// Initializes the view model with the specified capabilities and input.
    ///
    /// - Parameters:
    ///   - capabilities: A type that defines the capabilities of the view model.
    ///   - input: The input of the view model from the view.
    public init(
        capabilities: Capabilities,
        input: Input
    ) {
        self.capabilities = capabilities
        self.input = input
    }
}
