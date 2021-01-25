import XCTest
@testable import Quickfeed

final class QuickfeedTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Quickfeed().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
