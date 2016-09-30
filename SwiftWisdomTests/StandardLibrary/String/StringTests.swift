//
//  StringTests.swift
//  SwiftWisdom
//
//  Created by Benjamin Wu on 3/4/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class StringTests: XCTestCase {

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


    /** 
    // TODO: move into PasswordRequirements file

    func testNoRequirements() {
        let passwordRequirements = [PasswordRequirement]()
        XCTAssert("".ip_isValidPassword(passwordRequirements))
        XCTAssert(" ".ip_isValidPassword(passwordRequirements))
        XCTAssert("12garbage".ip_isValidPassword(passwordRequirements))
        XCTAssert("!!!".ip_isValidPassword(passwordRequirements))
        XCTAssert("Deadly Deadly Disco 12$".ip_isValidPassword(passwordRequirements))
    }

    func testSpecialCharRequirements() {
        let positiveRequirements = [PasswordRequirement.SpecialCharacters(exclude : false)]
        let negativeRequirements = [PasswordRequirement.SpecialCharacters(exclude : true)]

        XCTAssert(!"".ip_isValidPassword(positiveRequirements))
        XCTAssert("".ip_isValidPassword(negativeRequirements))

        XCTAssert("!".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"!".ip_isValidPassword(negativeRequirements))

        XCTAssert("!$&#".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"!%&#".ip_isValidPassword(negativeRequirements))

        XCTAssert(!"A".ip_isValidPassword(positiveRequirements))
        XCTAssert("A".ip_isValidPassword(negativeRequirements))

        XCTAssert("!A124adf".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"!A".ip_isValidPassword(negativeRequirements))
    }

    func testNumbersRequirements() {
        let positiveRequirements = [PasswordRequirement.Numbers(exclude : false)]
        let negativeRequirements = [PasswordRequirement.Numbers(exclude : true)]

        XCTAssert(!"".ip_isValidPassword(positiveRequirements))
        XCTAssert("".ip_isValidPassword(negativeRequirements))

        XCTAssert("1".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"1".ip_isValidPassword(negativeRequirements))

        XCTAssert("5345".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"2345".ip_isValidPassword(negativeRequirements))

        XCTAssert(!"A".ip_isValidPassword(positiveRequirements))
        XCTAssert("A".ip_isValidPassword(negativeRequirements))

        XCTAssert("A1dsf%^".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"A1".ip_isValidPassword(negativeRequirements))
    }

    func testLowercaseRequirements() {
        let positiveRequirements = [PasswordRequirement.Lowercase(exclude : false)]
        let negativeRequirements = [PasswordRequirement.Lowercase(exclude : true)]

        XCTAssert(!"".ip_isValidPassword(positiveRequirements))
        XCTAssert("".ip_isValidPassword(negativeRequirements))

        XCTAssert("a".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"a".ip_isValidPassword(negativeRequirements))

        XCTAssert("adffds".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"adffds".ip_isValidPassword(negativeRequirements))

        XCTAssert(!"A".ip_isValidPassword(positiveRequirements))
        XCTAssert("A".ip_isValidPassword(negativeRequirements))

        XCTAssert("a1FKGH$@%".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"a1".ip_isValidPassword(negativeRequirements))
    }

    func testUppercaseRequirements() {
        let positiveRequirements = [PasswordRequirement.Uppercase(exclude : false)]
        let negativeRequirements = [PasswordRequirement.Uppercase(exclude : true)]

        XCTAssert(!"".ip_isValidPassword(positiveRequirements))
        XCTAssert("".ip_isValidPassword(negativeRequirements))

        XCTAssert("A".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"A".ip_isValidPassword(negativeRequirements))

        XCTAssert("ADFKHDF".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"AFDJHFD".ip_isValidPassword(negativeRequirements))

        XCTAssert(!"a".ip_isValidPassword(positiveRequirements))
        XCTAssert("a".ip_isValidPassword(negativeRequirements))

        XCTAssert("a1A54872$%".ip_isValidPassword(positiveRequirements))
        XCTAssert(!"a1A".ip_isValidPassword(negativeRequirements))
    }

    func testMinimumRequirements() {
        let requirements = [PasswordRequirement.Minimum(length : 5)]

        XCTAssert(!"".ip_isValidPassword(requirements))
        XCTAssert(!"1".ip_isValidPassword(requirements))
        XCTAssert(!"1234".ip_isValidPassword(requirements))
        XCTAssert("12345".ip_isValidPassword(requirements))
        XCTAssert("123456".ip_isValidPassword(requirements))
        XCTAssert("jfngmyoskdsf123%#$@".ip_isValidPassword(requirements))
    }

    func testMaximumRequirements() {
        let requirements = [PasswordRequirement.Maximum(length : 5)]

        XCTAssert("".ip_isValidPassword(requirements))
        XCTAssert("1".ip_isValidPassword(requirements))
        XCTAssert("1234".ip_isValidPassword(requirements))
        XCTAssert("12345".ip_isValidPassword(requirements))
        XCTAssert(!"123456".ip_isValidPassword(requirements))
        XCTAssert(!"jfngmyoskdsf123%#$@".ip_isValidPassword(requirements))
    }

    func testRangeRequirements() {
        let requirements = [PasswordRequirement.Minimum(length : 3), PasswordRequirement.Maximum(length : 8)]

        XCTAssert(!"".ip_isValidPassword(requirements))
        XCTAssert(!"1".ip_isValidPassword(requirements))
        XCTAssert(!"12".ip_isValidPassword(requirements))
        XCTAssert("123".ip_isValidPassword(requirements))
        XCTAssert("123456".ip_isValidPassword(requirements))
        XCTAssert("1234567".ip_isValidPassword(requirements))
        XCTAssert("12345678".ip_isValidPassword(requirements))
        XCTAssert(!"123456789".ip_isValidPassword(requirements))
        XCTAssert(!"jfngmyoskdsf123%#$@".ip_isValidPassword(requirements))
    }

    func testBadMaxMinRequirements() {
        let badMinRequirements = [PasswordRequirement.Minimum(length: -1)]

        XCTAssert("".ip_isValidPassword(badMinRequirements))
        XCTAssert("fdf".ip_isValidPassword(badMinRequirements))
        XCTAssert("asdfasdf".ip_isValidPassword(badMinRequirements))

        let badMaxRequirements = [PasswordRequirement.Maximum(length: -1)]

        XCTAssert(!"".ip_isValidPassword(badMaxRequirements))
        XCTAssert(!"fdf".ip_isValidPassword(badMaxRequirements))
        XCTAssert(!"asdfasdf".ip_isValidPassword(badMaxRequirements))

        let conflictingRangeRequirements = [PasswordRequirement.Minimum(length: 5), PasswordRequirement.Maximum(length: 3)]

        XCTAssert(!"".ip_isValidPassword(conflictingRangeRequirements))
        XCTAssert(!"fdf".ip_isValidPassword(conflictingRangeRequirements))
        XCTAssert(!"asdfasdf".ip_isValidPassword(conflictingRangeRequirements))
    }

    func testCombinedRequiremnts() {
        let requirements: [PasswordRequirement] = [.SpecialCharacters(exclude: false),
                                                   .Numbers(exclude: false),
                                                   .Lowercase(exclude: false),
                                                   .Uppercase(exclude: true),
                                                   .Minimum(length: 3),
                                                   .Maximum(length: 10)]
        XCTAssert(!"".ip_isValidPassword(requirements))
        XCTAssert(!"1a".ip_isValidPassword(requirements))
        XCTAssert(!"!1aA".ip_isValidPassword(requirements))
        XCTAssert(!"AAA".ip_isValidPassword(requirements))
        XCTAssert(!"a23a".ip_isValidPassword(requirements))
        XCTAssert(!"!!!a".ip_isValidPassword(requirements))
        XCTAssert(!"a1!#akfsjgasdflj".ip_isValidPassword(requirements))
        
        XCTAssert("!1a".ip_isValidPassword(requirements))
        XCTAssert("^%$#a12".ip_isValidPassword(requirements))
        XCTAssert("@%@$#at12".ip_isValidPassword(requirements))
    }
 
 */
}
