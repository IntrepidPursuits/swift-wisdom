//
//  Array+UtilitiesTests.swift
//  SwiftWisdom
//
//  Created by Alexander Persian on 9/30/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

class ArrayUtilities: XCTestCase {

    func testSubArrayFromIndicesOf() {
        let testArray = [4, 8, 15, 16, 23, 42]
        let indices = testArray.ip_indices(ofElements: [15, 16, 19])
        let subTestArray = testArray.ip_subArray(fromIndices: indices)
        XCTAssert(subTestArray == [15, 16])
    }

    func testRemoveObject() {
        var testArray = [1, 5, 9, 14, 12]
        var result = testArray.ip_remove(object: 9)
        XCTAssertTrue(result)
        XCTAssert(testArray == [1, 5, 14, 12])

        result = testArray.ip_remove(object: 42)
        XCTAssertFalse(result)
        XCTAssert(testArray == [1, 5, 14, 12])
    }

    func testRemoveElements() {
        var testArray = [1, 5, 9, 14, 12]
        testArray.ip_remove(elements: [1, 5, 9])
        XCTAssert(testArray == [14, 12])
        testArray.ip_remove(elements: [12])
        XCTAssert(testArray == [14])
    }

    func testIndicesOf() {
        let testArray = [4, 8, 15, 16, 23, 42]
        XCTAssert(testArray.ip_indices(ofElements: [4, 16, 42]) == [0, 3, 5])
        XCTAssert(testArray.ip_indices(ofElements: [0, 1, 4]) == [NSNotFound, NSNotFound, 0])
    }

    func testContainsAll() {
        let testArray = [1, 5, 9, 14, 12]
        XCTAssert(testArray.ip_contains(all: [1, 12]))
        XCTAssertFalse(testArray.ip_contains(all: [14, 16]))
        XCTAssertFalse(testArray.ip_contains(all: [1, 5, 9, 10]))
    }
}
