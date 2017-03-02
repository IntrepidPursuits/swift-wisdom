//
//  NSDateComparableTests.swift
//  SwiftWisdom
//
//  Created by Patrick Butkiewicz on 3/1/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import Foundation
import XCTest

final class NSDateComparableTests: XCTestCase {
    let olderDate = NSDate(timeIntervalSince1970: 0)
    let olderDateCopy = NSDate(timeIntervalSince1970: 0)
    let moreRecentDate = NSDate(timeIntervalSinceNow: 0)
    
    func testLessThanDate() {
        XCTAssert(olderDate < moreRecentDate)
        XCTAssertFalse(olderDate < olderDateCopy)
    }
    
    func testLessThanOrEqual() {
        XCTAssert(olderDate <= moreRecentDate)
        XCTAssert(olderDate <= olderDateCopy)
    }
    
    func testGreaterThan() {
        XCTAssert(moreRecentDate > olderDate)
        XCTAssertFalse(olderDateCopy > olderDate)
    }
    
    func testGreaterThanOrEqual() {
        XCTAssert(moreRecentDate >= olderDate)
        XCTAssert(olderDate >= olderDateCopy)
    }
}
