//
//  ComparablesTests.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 7/2/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

class ComparablesTests: XCTestCase {
    func testConstrainBetween() {
        let five = 5.ip_constrainBetween(low: 0, high: 10)
        let negFive = -100.ip_constrainBetween(low: -5, high: 5)
        let twelve = 101.ip_constrainBetween(low: -2, high: 12)
        
        XCTAssert(five == 5)
        XCTAssert(negFive == -5)
        XCTAssert(twelve == 12)
    }
}
