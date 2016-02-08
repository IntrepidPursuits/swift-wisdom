//
//  IntegerTypeTests.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/30/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

class IntegerTypeTests: XCTestCase {

    func testEvenOdd() {
        XCTAssert(32.ip_isEven)
        XCTAssert(153.ip_isOdd)
        XCTAssert((-42).ip_isEven)
        XCTAssert((-1537).ip_isOdd)
    }
    
    func testTimes() {
        let count = 324
        var collection: [String] = []
        count.ip_times { collection.append("Hi") }
        XCTAssert(count == collection.count)
    }
}
