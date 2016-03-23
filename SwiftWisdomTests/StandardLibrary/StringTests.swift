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
    }

}
