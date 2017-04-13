import Foundation
import XCTest

public func ip_XCTAssertEqualOptional<T: Any>(_ expression1: @autoclosure () throws -> T?, _ expression2: @autoclosure () throws -> T?, _ message: String? = nil, file: StaticString = #file, line: UInt = #line) where T: Equatable {
    testHelper(expression1, expression2, message: message, file: file, line: line) { (lhs, rhs) in
        XCTAssertEqual(lhs, rhs, message ?? "", file: file, line: line)
    }
}

public func ip_XCTAssertNotEqualOptional<T: Any>(_ expression1: @autoclosure () throws -> T?, _ expression2: @autoclosure () throws -> T?, _ message: String? = nil, file: StaticString = #file, line: UInt = #line) where T: Equatable {
    testHelper(expression1, expression2, message: message, file: file, line: line) { (lhs, rhs) in
        XCTAssertNotEqual(lhs, rhs, message ?? "", file: file, line: line)
    }
}

public func ip_XCTAssertEqualWithAccuracyOptional<T : FloatingPoint>(_ expression1: @autoclosure () throws -> T?, _ expression2: @autoclosure () throws -> T?, _ accuracy: T, _ message: String? = nil, file: StaticString = #file, line: UInt = #line) {
    testHelper(expression1, expression2, message: message, file: file, line: line) { (lhs, rhs) in
        XCTAssertEqualWithAccuracy(lhs, rhs, accuracy: accuracy, message ?? "", file: file, line: line)
    }
}

public func ip_XCTAssertNotEqualWithAccuracyOptional<T : FloatingPoint>(_ expression1: @autoclosure () throws -> T?, _ expression2: @autoclosure () throws -> T?, _ accuracy: T, _ message: String? = nil, file: StaticString = #file, line: UInt = #line) {
    testHelper(expression1, expression2, message: message, file: file, line: line) { (lhs, rhs) in
        XCTAssertNotEqualWithAccuracy(lhs, rhs, accuracy, message ?? "", file: file, line: line)
    }
}

private func testHelper<T>(_ expression1: () throws -> T?, _ expression2: () throws -> T?, message: String?, file: StaticString, line: UInt, nonOptionalTest: (T, T) -> Void) {
    do {
        let exp1 = try expression1()
        let exp2 = try expression2()
        switch (exp1, exp2) {
        case let (left?, right?):
            nonOptionalTest(left, right)
        case (_?, _):
            XCTFail(message ?? "exp1 != nil, exp2 == nil", file: file, line: line)
        case (_, _?):
            XCTFail(message ?? "exp1 == nil, exp2 != nil", file: file, line: line)
        default: break
        }
    } catch let error {
        XCTFail(message ?? "caught \(error) while evaluating expressions", file: file, line: line)
    }
}
