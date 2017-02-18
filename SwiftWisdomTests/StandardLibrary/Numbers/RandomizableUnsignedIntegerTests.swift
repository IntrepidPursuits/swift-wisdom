//
//  RandomizableUnsignedIntegerTests.swift
//  SwiftWisdom
//
//  Created by Andrew Dolce on 2/17/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

class RandomizableUnsignedIntegerTests: XCTestCase {
    func testRandom() {
        let _: UInt8 = UInt8.ip_random()
        let _: UInt16 = UInt16.ip_random()
        let _: UInt32 = UInt32.ip_random()
        XCTAssert(true, "Generated random 8-bit, 16-bit, and 32-bit unsigned values without overflow")
    }
}
