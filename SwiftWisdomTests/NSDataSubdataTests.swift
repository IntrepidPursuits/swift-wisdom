//
//  NSData+SubdataTests.swift
//  bmap
//
//  Created by Logan Wright on 12/14/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class NSDataSubdataTests: XCTestCase {
    
    let one = "00 11 22"
        .ip_dataFromHexadecimalString()!
    let two = "33 44 55 66 77"
        .ip_dataFromHexadecimalString()!
    let three = "xx"
        .ip_dataFromHexadecimalString()!
    let four = "88 99 aa bb cc dd ee ff"
        .ip_dataFromHexadecimalString()!
    
    lazy var subdataArray: [Data] = [self.one, self.two, self.three, self.four]
    lazy var data: Data = self.subdataArray.combine()

    func testSubdata() {
        let fullSubData = data.ip_subdataFrom(0, length: data.count)
        XCTAssert(data == fullSubData)
        
        let emptySubDataValidIdx = data.ip_subdataFrom(5, length: 0)
        XCTAssert(emptySubDataValidIdx == nil)
        
        let emptySubDataInvalidIdx = data.ip_subdataFrom(1000, length: 234)
        XCTAssert(emptySubDataInvalidIdx == nil)
        
        let outOfRange = data.ip_subdataFrom(0, length: data.count + 1)
        XCTAssert(outOfRange == nil)
        
        subdataArray.enumerated().forEach { idx, compareSubdata in
            let previousData = subdataArray
                .prefix(upTo: idx)
                .combine()
            
            
            let subdata = data.ip_subdataFrom(previousData.count, length: compareSubdata.count)
            XCTAssert(subdata == compareSubdata)
        }
    }

    func testSubscriptIdx() {
        let zero = "4f"
        let one = "87"
        let two = "4f"
        let three = "a0"
        let combination = [zero, one, two, three].joined(separator: "")
        let data = combination.ip_dataFromHexadecimalString()!
        
        let zeroData = data[0]!
        XCTAssert(zeroData == zero.ip_dataFromHexadecimalString()!)
        
        let oneData = data[1]!
        XCTAssert(oneData == one.ip_dataFromHexadecimalString()!)
        
        let twoData = data[2]!
        XCTAssert(twoData == two.ip_dataFromHexadecimalString()!)
        
        let threeData = data[3]!
        XCTAssert(threeData == three.ip_dataFromHexadecimalString()!)
        
        let empty = data[100]
        XCTAssert(empty == nil)
    }
    
    func testPrefixSuffix() {
        let prefix = "af43 efda 651a".ip_dataFromHexadecimalString()!
        let suffix = "f4b4 2343".ip_dataFromHexadecimalString()!
        
        let data = NSMutableData()
        data.append(prefix)
        data.append(suffix)
        
        let gotPrefix = data.ip_prefixThrough(prefix.count - 1)
        XCTAssert(gotPrefix == prefix)
        
        let gotSuffix = data.ip_suffixFrom(prefix.count)
        XCTAssert(gotSuffix == suffix)
        
        let emptyPrefix = data.ip_prefixThrough(-1)
        XCTAssert(emptyPrefix == nil)
        
        let emptySuffix = data.ip_suffixFrom(100)
        XCTAssert(emptySuffix == emptySuffix)
    }

    func testSubscriptRange() {
        let zero = "4f"
        let one = "87"
        let two = "4f"
        let three = "a0"
        let combination = [zero, one, two, three].joined(separator: "")
        let data = combination.ip_dataFromHexadecimalString()!
        
        let getZeroAndOne = data[0...1]
        let zeroAndOne = (zero + one).ip_dataFromHexadecimalString()!
        XCTAssert(getZeroAndOne == zeroAndOne)
        
        let getOneTwoThree = data[1...3]
        let oneTwoThree = (one + two + three).ip_dataFromHexadecimalString()!
        XCTAssert(oneTwoThree == getOneTwoThree)
        
        let outOfRange = data[2...250]
        XCTAssert(outOfRange == nil)
        
        let outOfRangeLow = data[-2...4]
        XCTAssert(outOfRangeLow == nil)
    }
}

extension ArraySlice where Element : Data {
    func combine() -> Data {
        let data = NSMutableData()
        forEach(data.append(_:))
        return (NSData(data: data) as Data)
    }
}

extension Array where Element : Data {
    func combine() -> Data {
        let data = NSMutableData()
        forEach(data.append(_:))
        return (NSData(data: data) as Data)
    }
}
