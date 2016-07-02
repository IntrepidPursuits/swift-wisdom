//
//  TimeFromNumberTests.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 7/2/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest

class TimeFromNumberTests: XCTestCase {
    func testMinuteSeconds() {
        let timeA = 95
        let timeB = 125
        XCTAssert(timeA.minutesAndSecondsString == "1:35")
        XCTAssert(timeB.minutesAndSecondsString == "2:05")
    }
}
