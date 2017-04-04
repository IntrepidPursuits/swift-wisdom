import XCTest

class String_IndexingTests: XCTestCase {
    
    func testIpRangeNSRangeNegativeRangeReturnsNil() {
        XCTAssertNil("hello".ip_range(from: NSMakeRange(-1, 1)))
    }

    func testIpRangeNSRangeOutOfBoundsReturnsNil() {
        XCTAssertNil("hello".ip_range(from: NSMakeRange(3, 3)))
        XCTAssertNil("hello".ip_range(from: NSMakeRange(0, 6)))
    }

    func testIpRangeNSRangeRetunsProperRange() {
        assertIpRange(onString: "hello", withNSRange: NSMakeRange(0, 0))
        assertIpRange(onString: "hello", withNSRange: NSMakeRange(0, 5))
        assertIpRange(onString: "hello", withNSRange: NSMakeRange(1, 1))
    }

    func testIpRangeRangeRetunsProperRange() {
        let testString = "hello"
        XCTAssert(testString.substring(with: testString.ip_range(from: 0...0)) == "h")
        XCTAssert(testString.substring(with: testString.ip_range(from: 0...4)) == "hello")
        XCTAssert(testString.substring(with: testString.ip_range(from: 1...2)) == "el")
    }

    func testCountableClosedRangeSubscriptReturnsProperString() {
        XCTAssert("hello"[0...0] == "h")
        XCTAssert("hello"[0...1] == "he")
        XCTAssert("hello"[0...4] == "hello")
    }

    func testRangeSubscriptReturnsProperString() {
        XCTAssert("hello"[0..<0] == "")
        XCTAssert("hello"[0..<1] == "h")
        XCTAssert("hello"[0..<5] == "hello")
    }

    func testIpDropFirstWithNonEmptyString() {
        var testString = "Hello"
        testString.ip_dropFirst()
        XCTAssertEqual("ello", testString)
    }

    func testIpDropFirstWithEmptyString() {
        var emptyString = ""
        emptyString.ip_dropFirst()
        XCTAssert(emptyString.isEmpty)
    }

    func testSafeCountableClosedRange() {
        let hello = "Hello"
        XCTAssert(hello[ip_safely: 0...4] == "Hello")
        XCTAssert(hello[ip_safely: 0...3] == "Hell")
        XCTAssert(hello[ip_safely: 0...5] == "Hello")
    }

    func testSafeRange() {
        let hello = "Hello"
        XCTAssert(hello[ip_safely: 0..<5] == "Hello")
        XCTAssert(hello[ip_safely: 0..<4] == "Hell")
        XCTAssert(hello[ip_safely: 0..<6] == "Hello")
    }
}


// These methods are for testing only

fileprivate func assertIpRange(onString string: String, withNSRange nsrange: NSRange)  {
    guard let range = string.ip_range(from: nsrange) else {
        XCTAssert(false, "\(string).ip_range(NSRange(\(nsrange.location), \(nsrange.length)) returned nil")
        return
 }
    let lowerBoundsMatch = range.lowerBound == string.index(string.startIndex,
                                                            offsetBy: nsrange.location)
    let upperBoundsMatch = range.upperBound == string.index(string.startIndex,
                                                            offsetBy: nsrange.location + nsrange.length)
    XCTAssert(lowerBoundsMatch && upperBoundsMatch,
              "\(string).ip_range(NSRange(\(nsrange.location), \(nsrange.length)) does not return proper range")
}
