//
//  NSDataExtensionsTests.swift
//  bmap
//
//  Created by Logan Wright on 12/14/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class NSDataConversionTests: XCTestCase {
    
    func testHexString() {
        let number: UInt32 = 8723645
        let data = number.ip_data
        let hexString = data.ip_hexString!
        XCTAssert(hexString == "bd1c8500")
        
        let emptyData = Data()
        let emptyHexString = emptyData.ip_hexString
        XCTAssert(emptyHexString == nil)
    }

    func testHexInt() {
        let data = "1342 fa2a".ip_dataFromHexadecimalString()!
        let hexInt = data.ip_hexInt!
        XCTAssert(hexInt == 0x1342_fa2a)
        
        let emptyData = Data()
        let emptyHexInt = emptyData.ip_hexInt
        XCTAssert(emptyHexInt == nil)
    }
    
    func testUIntValue() {
        let originalInt: UInt = 987267519
        let data = originalInt.ip_data
        
        let hexInt = UInt(data.ip_intValue!)
        XCTAssert(hexInt == originalInt)
    }
    
    func testUTF8() {
        let data = "<48656c6c 6f2c2057 6f726c64 21>".ip_dataFromHexadecimalString()!
        let utf8String = data.ip_utf8String!
        XCTAssert(utf8String == "Hello, World!")
    }
    
    func testUInt8() {
        let data = Data(byte: 42)
        XCTAssert(data.ip_uint8Value == 42)
    }
    
    func testASCII() {
        let numberString = "321".data(using: String.Encoding.ascii)
        XCTAssert(numberString?.ip_asciiString == "321")
    }
}
