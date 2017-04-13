//
//  XCTestTests.swift
//  SwiftWisdom
//
//  Created by Colden Prime on 4/12/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import XCTest

class XCTestTests: XCTestCase {
    func testAssertEqualOptional() {
        let value1: Int? = 1
        let value2: Int? = 1

        ip_XCTAssertEqualOptional(value1, value2)
    }

    func testAssertNotEqualOptional() {
        let value1: Int? = 1
        let value2: Int? = 2

        ip_XCTAssertNotEqualOptional(value1, value2)
    }

    func testAssertEqualWithAccuracyOptional() {
        let value1: Float? = 1
        let value2: Float? = 1.00001

        ip_XCTAssertEqualWithAccuracyOptional(value1, value2, 0.0001)
    }

    func testAssertNotEqualWithAccuracyOptional() {
        let value1: Float? = 1
        let value2: Float? = 2.00001

        ip_XCTAssertNotEqualWithAccuracyOptional(value1, value2, 0.0001)
    }
}
