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
        let odd = 0.stride(through: 10, by: 2).filter { $0.ip_isOdd }
        XCTAssert(odd.count == 0)
        
        let even = 1.stride(through: 11, by: 2).filter { $0.ip_isEven }
        XCTAssert(even.count == 0)
    }
}
