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
        
        var none = maths
        none.removeAll()
        XCTAssertEqual(none.ip_mean(), 0)
    }
    
    func testMode() {
        let maths = [4, 5, 6, 9, 2, 4]
        let oddMaths = [4, 5, 6, 9, 4]
        XCTAssertEqual(maths.ip_mode(), [4])
        XCTAssertEqual(oddMaths.ip_mode(), [4])
    }
    
    func testManyModes() {
        let maths = [4, 5, 6, 6, 2, 4]
        let oddMaths = [4, 5, 6, 6, 4]
        let sameMaths = [1, 2, 9, 4, 5]
        XCTAssertEqual(maths.ip_mode(), [4, 6])
        XCTAssertEqual(oddMaths.ip_mode(), [4, 6])
        XCTAssertEqual(sameMaths.ip_mode(), sameMaths)
    }
    
    func testNoModes() {
        let maths = [4, 5, 6, 6, 2, 4]
        var emptyMaths = maths
        emptyMaths.removeAll()
        XCTAssertEqual(emptyMaths.ip_mode(), [])
    }
    
    func testMedian() {
        let maths = [4, 5, 6, 9, 2, 4]
        let oddMaths = [4, 5, 6, 9, 4]
        let doubleMaths = maths.map { Double($0) }
        XCTAssertEqual(maths.ip_median(), 4)
        XCTAssertEqual(oddMaths.ip_median(), 5)
        XCTAssertEqual(doubleMaths.ip_median(), 4.5)
    }
    
    func testAvgFunction() {
        let maths = [4, 5, 6, 9, 2, 4]
        var none = maths
        none.removeAll()
        let cgfloatmaths = maths.map { CGFloat($0) }
        let floatMaths = maths.map { Float($0) }
        XCTAssertEqual(avg(of: maths), 5)
        XCTAssertEqual(avg(of: cgfloatmaths), 5)
        XCTAssertEqual(avg(of: floatMaths), 5)
        XCTAssertEqual(avg(of: none), 0)
    }
}

