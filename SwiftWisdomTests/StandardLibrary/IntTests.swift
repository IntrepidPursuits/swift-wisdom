//
//  IntTests.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 3/31/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest

class IntTests: XCTestCase {
    func testOddEven() {
        let odd = stride(from: 0, through: 10, by: 2).filter { $0.ip_isOdd }
        XCTAssert(odd.count == 0)
        
        let even = stride(from: 1, through: 11, by: 2).filter { $0.ip_isEven }
        XCTAssert(even.count == 0)
    }
}
