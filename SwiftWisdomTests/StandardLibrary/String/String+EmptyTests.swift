import XCTest

class String_EmptyTests: XCTestCase {
    func testEmpty() {
        XCTAssertTrue("".ip_isEmptyOrWhitespace())
        XCTAssertTrue(" ".ip_isEmptyOrWhitespace())
        XCTAssertTrue("\n".ip_isEmptyOrWhitespace())
        XCTAssertTrue(" \n".ip_isEmptyOrWhitespace())
        XCTAssertFalse("a".ip_isEmptyOrWhitespace())
        XCTAssertFalse("a\n".ip_isEmptyOrWhitespace())
        XCTAssertFalse("\na\n".ip_isEmptyOrWhitespace())
        XCTAssertFalse("ab".ip_isEmptyOrWhitespace())
    }
}
