//
//  DataSubscriptTests.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 11/10/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class DataSubdataTests: XCTestCase {
    
    let one = "00 11 22"
        .ip_dataFromHexadecimalString()!
    let two = "33 44 55 66 77"
        .ip_dataFromHexadecimalString()!
    let three = "xx"
        .ip_dataFromHexadecimalString()!
    let four = "88 99 aa bb cc dd ee ff"
        .ip_dataFromHexadecimalString()!
    
    lazy var subdataArray: [Data] = [self.one, self.two, self.three, self.four]
    var data = Data()
    
    func testSubscripts() {
        subdataArray.forEach { data.append($0) }

        let fullSubData = data[ip_safely: 0..<data.count]
        XCTAssert(data == fullSubData)
        
        let fullSubDataClosedRange = data[ip_safely: 0...data.endIndex - 1]
        XCTAssert(data == fullSubDataClosedRange)
        
        let middleTwoSubdata = data[ip_safely: 1...2]
        XCTAssert(middleTwoSubdata == data.subdata(in: 1..<3))
        
        let emptySubDataValidIdx = data[ip_safely: 2..<2]
        XCTAssert(emptySubDataValidIdx == nil)
        
        let emptySubDataInvalidIdx = data[ip_safely: 1000...1234]
        XCTAssert(emptySubDataInvalidIdx == nil)
        
        let outOfRange = data[ip_safely: 0..<data.count + 1]
        XCTAssert(outOfRange == nil)
        
        let last = data[ip_safely: data.endIndex - 1]?.ip_uint8Value
        XCTAssert(last == data.last)
    }
    
    func testChunking() {
        data = Data()
        subdataArray.forEach { data.append($0) }
        
        let byThree = data.ip_chunks(ofLength: 3, includeRemainder: false)
        XCTAssert(byThree.first == one)
        XCTAssert(byThree.last == "bb cc dd".ip_dataFromHexadecimalString())
        
        let byThreeRemainder = data.ip_chunks(ofLength: 3, includeRemainder: true)
        XCTAssert(byThreeRemainder[1] == "33 44 55".ip_dataFromHexadecimalString())
        XCTAssert(byThreeRemainder.last == "ee ff".ip_dataFromHexadecimalString())
        
        XCTAssert(data.count == one.count + two.count + three.count + four.count)
    }
}
