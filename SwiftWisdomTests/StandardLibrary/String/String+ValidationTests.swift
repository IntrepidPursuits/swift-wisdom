import XCTest
@testable import SwiftWisdom

class String_ValidationTests: XCTestCase {
    
    func testValidEmail() {
        XCTAssertFalse("".ip_isValidEmail())
        XCTAssertFalse("@".ip_isValidEmail())
        XCTAssertFalse("@.".ip_isValidEmail())
        XCTAssertFalse("@.com".ip_isValidEmail())
        XCTAssertFalse("foo@.com".ip_isValidEmail())
        XCTAssertFalse("@foo.com".ip_isValidEmail())
        XCTAssertTrue("f@b.c".ip_isValidEmail())
        XCTAssertTrue("foo@bar.com".ip_isValidEmail())
        XCTAssertFalse("f@b.".ip_isValidEmail())
    }

    func testNoRequirements() {
        let passwordRequirements = [PasswordRequirement]()
        XCTAssert("".ip_isValidPassword(requirements: passwordRequirements))
        XCTAssert(" ".ip_isValidPassword(requirements: passwordRequirements))
        XCTAssert("12garbage".ip_isValidPassword(requirements: passwordRequirements))
        XCTAssert("!!!".ip_isValidPassword(requirements: passwordRequirements))
        XCTAssert("Deadly Deadly Disco 12$".ip_isValidPassword(requirements: passwordRequirements))
    }

    func testSpecialCharRequirements() {
        let positiveRequirements = [PasswordRequirement.specialCharacters(exclude : false)]
        let negativeRequirements = [PasswordRequirement.specialCharacters(exclude : true)]

        XCTAssert(!"".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert("".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("!".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"!".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("!$&#".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"!%&#".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert(!"A".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert("A".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("!A124adf".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"!A".ip_isValidPassword(requirements: negativeRequirements))
    }

    func testNumbersRequirements() {
        let positiveRequirements = [PasswordRequirement.numbers(exclude : false)]
        let negativeRequirements = [PasswordRequirement.numbers(exclude : true)]

        XCTAssert(!"".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert("".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("1".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"1".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("5345".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"2345".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert(!"A".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert("A".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("A1dsf%^".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"A1".ip_isValidPassword(requirements: negativeRequirements))
    }

    func testLowercaseRequirements() {
        let positiveRequirements = [PasswordRequirement.lowercase(exclude : false)]
        let negativeRequirements = [PasswordRequirement.lowercase(exclude : true)]

        XCTAssert(!"".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert("".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("a".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"a".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("adffds".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"adffds".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert(!"A".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert("A".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("a1FKGH$@%".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"a1".ip_isValidPassword(requirements: negativeRequirements))
    }

    func testUppercaseRequirements() {
        let positiveRequirements = [PasswordRequirement.uppercase(exclude : false)]
        let negativeRequirements = [PasswordRequirement.uppercase(exclude : true)]

        XCTAssert(!"".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert("".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("A".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"A".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("ADFKHDF".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"AFDJHFD".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert(!"a".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert("a".ip_isValidPassword(requirements: negativeRequirements))

        XCTAssert("a1A54872$%".ip_isValidPassword(requirements: positiveRequirements))
        XCTAssert(!"a1A".ip_isValidPassword(requirements: negativeRequirements))
    }

    func testMinimumRequirements() {
        let requirements = [PasswordRequirement.minimum(length : 5)]

        XCTAssert(!"".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"1".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"1234".ip_isValidPassword(requirements: requirements))
        XCTAssert("12345".ip_isValidPassword(requirements: requirements))
        XCTAssert("123456".ip_isValidPassword(requirements: requirements))
        XCTAssert("jfngmyoskdsf123%#$@".ip_isValidPassword(requirements: requirements))
    }

    func testMaximumRequirements() {
        let requirements = [PasswordRequirement.maximum(length : 5)]

        XCTAssert("".ip_isValidPassword(requirements: requirements))
        XCTAssert("1".ip_isValidPassword(requirements: requirements))
        XCTAssert("1234".ip_isValidPassword(requirements: requirements))
        XCTAssert("12345".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"123456".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"jfngmyoskdsf123%#$@".ip_isValidPassword(requirements: requirements))
    }

    func testRangeRequirements() {
        let requirements = [PasswordRequirement.minimum(length : 3), PasswordRequirement.maximum(length : 8)]

        XCTAssert(!"".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"1".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"12".ip_isValidPassword(requirements: requirements))
        XCTAssert("123".ip_isValidPassword(requirements: requirements))
        XCTAssert("123456".ip_isValidPassword(requirements: requirements))
        XCTAssert("1234567".ip_isValidPassword(requirements: requirements))
        XCTAssert("12345678".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"123456789".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"jfngmyoskdsf123%#$@".ip_isValidPassword(requirements: requirements))
    }

    func testBadMaxMinRequirements() {
        let badMinRequirements = [PasswordRequirement.minimum(length: -1)]

        XCTAssert("".ip_isValidPassword(requirements: badMinRequirements))
        XCTAssert("fdf".ip_isValidPassword(requirements: badMinRequirements))
        XCTAssert("asdfasdf".ip_isValidPassword(requirements: badMinRequirements))

        let badMaxRequirements = [PasswordRequirement.maximum(length: -1)]

        XCTAssert(!"".ip_isValidPassword(requirements: badMaxRequirements))
        XCTAssert(!"fdf".ip_isValidPassword(requirements: badMaxRequirements))
        XCTAssert(!"asdfasdf".ip_isValidPassword(requirements: badMaxRequirements))

        let conflictingRangeRequirements = [PasswordRequirement.minimum(length: 5), PasswordRequirement.maximum(length: 3)]

        XCTAssert(!"".ip_isValidPassword(requirements: conflictingRangeRequirements))
        XCTAssert(!"fdf".ip_isValidPassword(requirements: conflictingRangeRequirements))
        XCTAssert(!"asdfasdf".ip_isValidPassword(requirements: conflictingRangeRequirements))
    }

    func testCombinedRequirements() {
        let requirements: [PasswordRequirement] = [.specialCharacters(exclude: false),
                                                   .numbers(exclude: false),
                                                   .lowercase(exclude: false),
                                                   .uppercase(exclude: true),
                                                   .minimum(length: 3),
                                                   .maximum(length: 10)]
        XCTAssert(!"".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"1a".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"!1aA".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"AAA".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"a23a".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"!!!a".ip_isValidPassword(requirements: requirements))
        XCTAssert(!"a1!#akfsjgasdflj".ip_isValidPassword(requirements: requirements))
        
        XCTAssert("!1a".ip_isValidPassword(requirements: requirements))
        XCTAssert("^%$#a12".ip_isValidPassword(requirements: requirements))
        XCTAssert("@%@$#at12".ip_isValidPassword(requirements: requirements))
    }
}
