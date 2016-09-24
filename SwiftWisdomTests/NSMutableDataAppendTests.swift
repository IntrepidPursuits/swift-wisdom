//
//  NSMutableDataAppendTests.swift
//  bmap
//
//  Created by Logan Wright on 12/14/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class NSMutableDataAppendTests: XCTestCase {

    let startData = "faff afac deaf dc3f"
        .ip_dataFromHexadecimalString()!

    func testAppendByte() {
        let byte: UInt8 = 100
        
        let mutable = NSMutableData()
        mutable.ip_appendByte(byte)
        
        XCTAssert(UInt8(mutable.ip_intValue!) == byte)
    }
    
    
    func testAppendString() {
        let string = "Hello, Append Data!"
    
        let mutable = NSMutableData()
        mutable.appendUTF8String(string)
        
        let stringData = string.data(using: String.Encoding.utf8)!
        XCTAssert(mutable == stringData)
    }
    
}
