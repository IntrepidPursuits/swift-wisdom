//
//  NSDataTrimTests.swift
//  bmap
//
//  Created by Logan Wright on 12/14/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom


class NSDataTrimTests: XCTestCase {
    
    func testTrimRange() {
        let data = "aa 11 11 11 11 11 bb".ip_dataFromHexadecimalString()!
        let mutable = NSMutableData(data: data as Data)
        mutable.ip_trimRange(0...3)
        XCTAssert(mutable as NSData == data.ip_suffixFrom(4))
        
        
        let endMutable = NSMutableData(data: data as Data)
        endMutable.ip_trimRange(3...100)
        XCTAssert(endMutable == data.ip_prefixThrough(2))
    }
}
