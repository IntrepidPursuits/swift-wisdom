//
//  SequenceTests.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 3/31/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest

class SequenceTests: XCTestCase {
    func testSplitFilter() {
        let (greaterThan50, lessThanOrEqualTo50) = Array(1...100).ip_splitFilter { $0 > 50 }
        XCTAssert(greaterThan50 == Array(51...100))
        XCTAssert(lessThanOrEqualTo50 == Array(1...50))
    }
}
