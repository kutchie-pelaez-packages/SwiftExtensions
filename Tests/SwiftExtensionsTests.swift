@testable import SwiftExtensions
import XCTest

final class SwiftExtensionsTests: XCTestCase {
    func testCollectionSplit() {
        XCTAssertEqual("1223334444".split(maxSplits: 3) { $0 != $1 }, ["1", "22", "333"])
        XCTAssertEqual("camelCaseString".camelCaseSplitted(), ["camel", "Case", "String"])
        XCTAssertEqual("snake_case_string".snakeCaseSplitted(), ["snake", "case", "string"])
    }

    func testComparableClamped() {
        XCTAssertEqual(5.clamped(10...20), 10)
        XCTAssertEqual(15.clamped(10...20), 15)
        XCTAssertEqual(25.clamped(10...20), 20)
        XCTAssertEqual(5.clamped(10...), 10)
        XCTAssertEqual(15.clamped(10...), 15)
        XCTAssertEqual(15.clamped(...20), 15)
        XCTAssertEqual(25.clamped(...20), 20)
    }

    func testDictionaryUnwrapped() {
        XCTAssertEqual(["a": 1, "b": nil].unwrapped(), ["a": 1])
    }

    func testDictionaryAppending() {
        XCTAssertEqual(["a": 1].appending(["a": 2]), ["a": 1])
    }

    func testDictionaryOverriding() {
        XCTAssertEqual(["a": 1].overriding(with: ["a": 2]), ["a": 2])
    }
}
