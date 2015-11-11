import Foundation
import XCTest

public func ip_XCTAssertEqualOptional<T: Any where T: Equatable>(@autoclosure expression1: () -> T?, @autoclosure expression2: () -> T?, _ message: String? = nil, file: String = __FILE__, line: UInt = __LINE__) {
    let exp1 = expression1()
    let exp2 = expression2()
    switch (exp1, exp2) {
    case let (left?, right?):
        XCTAssertEqual(left, right, message ?? "", file: file, line: line)
    case (_?, _):
        XCTFail(message ?? "exp1 != nil, exp2 == nil", file: file, line: line)
    case (_, _?):
        XCTFail(message ?? "exp1 == nil, exp2 != nil", file: file, line: line)
    default: break
    }
}

public func ip_XCTAssertEqualWithAccuracyOptional<T : FloatingPointType>(@autoclosure expression1: () -> T?, @autoclosure _ expression2: () -> T?, accuracy: T, _ message: String? = nil, file: String = __FILE__, line: UInt = __LINE__) {
    let exp1 = expression1()
    let exp2 = expression2()
    switch (exp1, exp2) {
    case let (left?, right?):
        XCTAssertEqualWithAccuracy(left, right, accuracy: accuracy, message ?? "", file: file, line: line)
    case (_?, _):
        XCTFail(message ?? "exp1 != nil, exp2 == nil", file: file, line: line)
    case (_, _?):
        XCTFail(message ?? "exp1 == nil, exp2 != nil", file: file, line: line)
    default: break
    }
}