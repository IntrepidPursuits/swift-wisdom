//
//  CountableClosedRange+ExtensionsTests.swift
//  SwiftWisdom
//
//  Created by Andrew Dolce on 11/21/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

class CountableClosedRangeExtensionTests: XCTestCase {

    func testRandomInRange() {
        let positives = 0...100
        XCTAssert(positives.contains(positives.ip_random()))
        let negatives = -100...(-50)
        XCTAssert(negatives.contains(negatives.ip_random()))
        let mixed = -100...100
        XCTAssert(mixed.contains(mixed.ip_random()))
    }
}
