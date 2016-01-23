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
    let ProductName = "Hello, Headphone Name!".dataUsingEncoding(NSUTF8StringEncoding)!
    let ProductInfoProductNameRawPacketPrefix = "<0102a616>"
        .ip_dataFromHexadecimalString()!
    
    let extraAppendedData = "2342 afa2 ffed 2222"
        .ip_dataFromHexadecimalString()!
    
    lazy var ProductInfoProductNameRawPacketData: NSData = {
        let mutable = NSMutableData()
        mutable.appendData(self.ProductInfoProductNameRawPacketPrefix)
        mutable.appendData(self.ProductName)
        mutable.appendData(self.extraAppendedData)
        return NSData(data: mutable)
    }()
    
    func testTrimRange() {
        let data = "aa 11 11 11 11 11 bb".ip_dataFromHexadecimalString()!
        let mutable = NSMutableData(data: data)
        mutable.ip_trimRange(0...3)
        XCTAssert(mutable == data.ip_suffixFrom(4)!)
        
        
        let endMutable = NSMutableData(data: data)
        endMutable.ip_trimRange(3...100)
        XCTAssert(endMutable == data.ip_prefixThrough(2))
    }
}
