import XCTest
@testable import PartitionBar

final class PartitionBarTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PartitionBar().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
