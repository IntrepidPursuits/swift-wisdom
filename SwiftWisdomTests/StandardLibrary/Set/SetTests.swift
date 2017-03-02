//
//  SetTests.swift
//  SwiftWisdom
//
//  Created by Patrick Butkiewicz on 3/1/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import Foundation
import XCTest

final class SetTests: XCTestCase {
    private let evenSet = Set(arrayLiteral: 2, 4, 6, 8)

    func testSetFiltering() {
        let filtered = evenSet.ip_filter({ $0 % 2 == 0 })
        XCTAssert(filtered.count == evenSet.count)
    }
    
    func testSetIsPassing() {
        let successTest = evenSet.ip_passes(test: { $0 % 2 == 0 })
        XCTAssert(successTest)
        let failedTest = evenSet.ip_passes(test: { $0 % 2 == 1 })
        XCTAssertFalse(failedTest)
    }
    
    func testSetToArray() {
        let setToArray = evenSet.ip_toArray()
        XCTAssert(setToArray.count == evenSet.count)
    }
}
