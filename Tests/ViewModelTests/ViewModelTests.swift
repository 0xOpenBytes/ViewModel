import SwiftUI
import XCTest
@testable import ViewModel

final class ViewModelTests: XCTestCase {
    func testExample() throws {
        class ExampleViewModel: ViewModel<Void, ExampleViewModel.Input, String> {
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

        let viewModel = ExampleViewModel()

        XCTAssertEqual(viewModel.content, "")

        viewModel.input.textInput = "Hello World"

        XCTAssertEqual(viewModel.content, "Hello World")

        let textView: Text = try XCTUnwrap(
            viewModel.view { content in
                Text(verbatim: content)
            } as? Text
        )

        let expectedTextView: Text = Text(verbatim: "Hello World")

        XCTAssertEqual(textView, expectedTextView)
    }
}
