import XCTest
@testable import J_jwt_library

final class J_jwt_libraryTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(J_jwt_library().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
