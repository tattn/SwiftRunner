import XCTest
import SwiftRunner

class SwiftRunnerTests: XCTestCase {
    func testPrintHello() {
        let result = SwiftRunner.shared.launchSwift(string: "print(\"hello\")")
        if case .success(let stream) = result {
            XCTAssertEqual(stream.output, "hello\n")
            XCTAssertEqual(stream.error, "")
        } else {
            XCTFail()
        }
    }

    func testCompileError() {
        let result = SwiftRunner.shared.launchSwift(string: "print(hello)")
        if case .success(let stream) = result {
            XCTAssertEqual(stream.output, "")
            XCTAssertFalse(stream.error.isEmpty) // error message may change, so it checks whether it is not empty
        } else {
            XCTFail()
        }
    }


    static var allTests : [(String, (SwiftRunnerTests) -> () throws -> Void)] {
        return [
            ("testPrintHello", testPrintHello),
            ("testCompileError", testCompileError),
        ]
    }
}
