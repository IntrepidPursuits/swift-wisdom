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

    func test_bitStackOfLength() {
        XCTAssertEqual(UInt8.ip_bitStackOfLength(-1), UInt8(0))
        XCTAssertEqual(UInt8.ip_bitStackOfLength(0), UInt8(1 - 1)) // 2^0 - 1
        XCTAssertEqual(UInt8.ip_bitStackOfLength(1), UInt8(2 - 1)) // 2^1 - 1
        XCTAssertEqual(UInt8.ip_bitStackOfLength(2), UInt8(4 - 1)) // 2^2 - 1
        XCTAssertEqual(UInt8.ip_bitStackOfLength(8), UInt8(256 - 1)) // 2^8 - 1

        // overflow just returns the max number of 1s for that type
        XCTAssertEqual(UInt8.ip_bitStackOfLength(9), UInt8(256 - 1)) // 2^8 - 1
        XCTAssertEqual(UInt16.ip_bitStackOfLength(16), UInt16(65536 - 1)) // 2^16 - 1
    }

    func testUInt16EndianConversion() {
        let value: UInt16 = 1
        XCTAssertEqual(Data([0x00, 0x01]), value.ip_bigEndianData)
        XCTAssertEqual(Data([0x01, 0x00]), value.ip_littleEndianData)
    }

    func testUInt32EndianConversion() {
        let value: UInt32 = 1
        XCTAssertEqual(Data([0x00, 0x00, 0x00, 0x01]), value.ip_bigEndianData)
        XCTAssertEqual(Data([0x01, 0x00, 0x00, 0x00]), value.ip_littleEndianData)
    }

    func testUInt64EndianConversion() {
        let value: UInt64 = 1
        XCTAssertEqual(Data([0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01]), value.ip_bigEndianData)
        XCTAssertEqual(Data([0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]), value.ip_littleEndianData)
    }
}
