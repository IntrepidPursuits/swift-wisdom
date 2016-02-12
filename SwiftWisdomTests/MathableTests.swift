//
//  MathableTests.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 2/12/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

class MathableTests: XCTestCase {
    
    func testMean() {
        let maths = [4, 5, 6, 9, 2, 4]
        let cgfloatmaths = maths.map { CGFloat($0) }
        XCTAssertEqual(maths.ip_mean(), 5)
        XCTAssertEqual(cgfloatmaths.ip_mean(), 5)
    }
    
    func testMode() {
        let maths = [4, 5, 6, 9, 2, 4]
        XCTAssertEqual(maths.ip_mode()!, [4])
    }
    
    func testMedian() {
        let maths = [4, 5, 6, 9, 2, 4]
        XCTAssertEqual(maths.ip_median(), 4.5)
    }
}

