//
//  IntegerTypeTests.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/30/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

class IntegerTypeTests: XCTestCase {

    func testEvenOdd() {
        XCTAssert(32.ip_isEven)
        XCTAssert(153.ip_isOdd)
        XCTAssert((-42).ip_isEven)
        XCTAssert((-1537).ip_isOdd)
    }
    
    func testTimes() {
        let count = 324
        var collection: [String] = []
        count.ip_times { collection.append("Hi") }
        XCTAssert(count == collection.count)
    }
    
    func testToMagnitudeString() {      
        let numbers = [14, 1234, 15420003, 5678000000, 8888000000000, 999999]
        let formattedNumbersOnePlace = ["14", "1.2K", "15.4M", "5.7B", "8.9T", "1M"]
        let formattedNumbersTwoPlaces = ["14", "1.23K", "15.42M", "5.68B", "8.89T", "1M"]
        
        for (index, number) in numbers.enumerate() {
            let formattedNumber = number.ip_toMagnitudeString()
            XCTAssertEqual(formattedNumber, formattedNumbersOnePlace[index])
        }
        
        for (index, number) in numbers.enumerate() {
            let formattedNumber = number.ip_toMagnitudeString(decimalPlaces: 2)
            XCTAssertEqual(formattedNumber, formattedNumbersTwoPlaces[index])
        }
    }
}
