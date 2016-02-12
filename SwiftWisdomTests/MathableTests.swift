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
        let floatMaths = maths.map { Float($0) }
        XCTAssertEqual(maths.ip_mean(), 5)
        XCTAssertEqual(cgfloatmaths.ip_mean(), 5)
        XCTAssertEqual(floatMaths.ip_mean(), 5)
    }
    
    func testMode() {
        let maths = [4, 5, 6, 9, 2, 4]
        let oddMaths = [4, 5, 6, 9, 4]
        XCTAssertEqual(maths.ip_mode()!, [4])
        XCTAssertEqual(oddMaths.ip_mode()!, [4])
    }
    
    func testManyModes() {
        let maths = [4, 5, 6, 6, 2, 4]
        let oddMaths = [4, 5, 6, 6, 4]
        XCTAssertEqual(maths.ip_mode()!, [4, 6])
        XCTAssertEqual(oddMaths.ip_mode()!, [4, 6])
    }
    
    func testMedian() {
        let maths = [4, 5, 6, 9, 2, 4]
        let oddMaths = [4, 5, 6, 9, 4]
        XCTAssertEqual(maths.ip_median(), 4)
        XCTAssertEqual(oddMaths.ip_median(), 5)
    }
}

