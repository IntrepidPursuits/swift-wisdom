//
//  UnsignedInteger+ExtensionsTests.swift
//  SwiftWisdom
//
//  Created by Tom O'Malley on 9/30/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

class UnsignedIntegerExtensionTests: XCTestCase {

    func testRandomInRange() {
        let positives = 0...100
        XCTAssert(positives.contains(random(inRange: positives)))
        let negatives = -100...(-50)
        XCTAssert(negatives.contains(random(inRange: negatives)))
        let mixed = -100...100
        XCTAssert(mixed.contains(random(inRange: mixed)))
    }
}
