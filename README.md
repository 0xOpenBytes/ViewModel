# ViewModel

ViewModel is a SwiftUI framework that provides a starting point for your SwiftUI ViewModels. It makes it easier to structure your code and manage the state and behavior of your views.

## Usage

To use SwiftUI ViewModel, create a subclass of `ViewModel` with `Capabilities`, `Input`, and `Content` types, and implement the content property with the content for the view. You can also provide additional properties and methods to manage the state and behavior of the view.

Here's an example of a simple view model:

```swift
class MyViewModel: ViewModel<Void, Void, MyContent> {
    @Published private var title: String = "Hello, World!"

    override var content: MyContent {
        MyContent(title: title)
    }
    
    init() {
        super.init(capabilities: (), input: ())
    }
}
```

In this example, `MyViewModel` has no capabilities or input, and its content is a `MyContent` object with a title property set to "Hello, World!".

To use this view model in a view, you can create an instance of `MyViewModel` and use its view method to return a `view` with the specified content and bindings:

```swift
struct MyView: View {
    @ObservedObject var viewModel = MyViewModel()

    var body: some View {
        viewModel.view { content in
            Text(content)
        }
    }
}
```

### Bindings

If you need to have a `Binding` for a value, you can define it in the `Input` struct of your ViewModel. Here's an example of a ViewModel with Input:

```swift
class InputViewModel: ViewModel<Void, InputViewModel.Input, String> {
    struct Input {
        var textInput: String = ""
    }

    override var content: String {
        input.textInput
    }

    init() {
        super.init(capabilities: (), input: Input())
    }
}
```

To use this ViewModel in a view, you can use the `binding` method to get a `Binding` for the `textInput` property:

```swift
struct InputView: View {
    @ObservedObject var viewModel = InputViewModel()

    var body: some View {
        viewModel.view { content, binding in
            TextField("Enter some text", text: binding(\.textInput))
        }
    }
}
```
