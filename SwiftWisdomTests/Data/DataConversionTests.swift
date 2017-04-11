
//
//  DataConversionTests.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 11/11/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class DataConversionTests: XCTestCase {
    
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

    func testUInt16() {
        var data = Data(bytes: [0x00, 0x01])
        XCTAssertEqual(data.ip_uint16Value?.bigEndian, 1)
        XCTAssertEqual(Data(data.reversed()).ip_uint16Value?.littleEndian, 1)

        data = Data()
        XCTAssertEqual(data.ip_uint16Value?.bigEndian, nil)
        XCTAssertEqual(Data(data.reversed()).ip_uint16Value?.littleEndian, nil)
    }

    func testUInt32() {
        var data = Data(bytes: [0x00, 0x00, 0x00, 0x01])
        XCTAssertEqual(data.ip_uint32Value?.bigEndian, 1)
        XCTAssertEqual(Data(data.reversed()).ip_uint32Value?.littleEndian, 1)

        data = Data()
        XCTAssertEqual(data.ip_uint32Value?.bigEndian, nil)
        XCTAssertEqual(Data(data.reversed()).ip_uint32Value?.littleEndian, nil)
    }

    func testUInt64() {
        var data = Data(bytes: [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01])
        XCTAssertEqual(data.ip_uint64Value?.bigEndian, 1)
        XCTAssertEqual(Data(data.reversed()).ip_uint64Value?.littleEndian, 1)

        data = Data()
        XCTAssertEqual(data.ip_uint64Value?.bigEndian, nil)
        XCTAssertEqual(Data(data.reversed()).ip_uint64Value?.littleEndian, nil)
    }

    func testInt16() {
        var data = Data(bytes: [0x00, 0x01])
        XCTAssertEqual(data.ip_int16Value?.bigEndian, 1)
        XCTAssertEqual(Data(data.reversed()).ip_int16Value?.littleEndian, 1)

        data = Data(bytes: [0xFF, 0xFE])
        XCTAssertEqual(data.ip_int16Value?.bigEndian, -2)
        XCTAssertEqual(Data(data.reversed()).ip_int16Value?.littleEndian, -2)

        data = Data()
        XCTAssertEqual(data.ip_int16Value?.bigEndian, nil)
        XCTAssertEqual(data.ip_int16Value?.littleEndian, nil)
    }

    func testInt32() {
        var data = Data(bytes: [0x00, 0x00, 0x00, 0x01])
        XCTAssertEqual(data.ip_int32Value?.bigEndian, 1)
        XCTAssertEqual(Data(data.reversed()).ip_int32Value?.littleEndian, 1)

        data = Data(bytes: [0xFF, 0xFF, 0xFF, 0xFE])
        XCTAssertEqual(data.ip_int32Value?.bigEndian, -2)
        XCTAssertEqual(Data(data.reversed()).ip_int32Value?.littleEndian, -2)

        data = Data()
        XCTAssertEqual(data.ip_int32Value?.bigEndian, nil)
        XCTAssertEqual(data.ip_int32Value?.littleEndian, nil)
    }

    func testInt64() {
        var data = Data(bytes: [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01])
        XCTAssertEqual(data.ip_int64Value?.bigEndian, 1)
        XCTAssertEqual(Data(data.reversed()).ip_int64Value?.littleEndian, 1)

        data = Data(bytes: [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE])
        XCTAssertEqual(data.ip_int64Value?.bigEndian, -2)
        XCTAssertEqual(Data(data.reversed()).ip_int64Value?.littleEndian, -2)

        data = Data()
        XCTAssertEqual(data.ip_int64Value?.bigEndian, nil)
        XCTAssertEqual(data.ip_int64Value?.littleEndian, nil)
    }

    func testInt8() {
        let data = "ff".ip_dataFromHexadecimalString() //two's complement
        XCTAssert(data?.ip_int8Value == -1)
    }
    
    func testASCII() {
        let numberString = "321".data(using: String.Encoding.ascii)!
        XCTAssert((numberString as Data).ip_asciiString == "321")
    }

    func testIntSmallValue() {
        let intData = Data(bytes: [25])
        XCTAssert(intData.ip_intValue == 25)
        XCTAssert(intData.ip_int64Value == 25)

        let intDataTwo = Data(bytes: [4,5]) // 0000_0101_0000_0100
        XCTAssert(intDataTwo.ip_intValue == 1284)
    }
    
    // MARK: Testing DataConvertible protocol
    
    func testInt8Conversion() {
        let data = Int8(-42).ip_data
        let backToNum = Int8(ip_data: data)
        XCTAssert(backToNum == -42)

        let longData = Data(bytes: [4,5,6,7])
        XCTAssertNil(Int8(ip_data: longData))
    }
    
    func testInt64Conversion() {
        let data = Int64(-4232).ip_data
        let backToNum = Int64(ip_data: data)
        XCTAssert(backToNum == -4232)

        let longData = Data(bytes: [4,5,6,7,8,9,10,11,12,13,14])
        XCTAssertNil(Int64(ip_data: longData))
    }

    func testIntegerConversion() {
        let data = Int(-100055).ip_data // Be careful with the signed bit boundary.
        let backToNum = Int(ip_data: data)
        XCTAssert(backToNum == -100055)
    }
    
    func testDoubleConversion() {
        let data = Double(421.4566).ip_data
        let backToNum = Double(ip_data: data)
        XCTAssert(backToNum == 421.4566)
    }
    
    func testBitsOfIntegerConversion() {
        let data = Int8(2).ip_data
        if let bitMask = data.ip_uint8Value?.ip_maskedIndexes {
            XCTAssert(bitMask == [1])
        } else {
            XCTFail()
        }
    }
    
}
