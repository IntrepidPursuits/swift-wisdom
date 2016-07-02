//
//  CollectionTypeTests.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 2/12/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

class CollectionTests: XCTestCase {
    
    func testMostCommonElement() {
        let strings = ["b", "b", "v", "v"]
        XCTAssertEqual(strings.ip_mostCommonElements(), ["b", "v"])
        let numbers = [1, 2, 3, 4, 5, 6, 6, 7]
        let noMode = [1, 2, 3, 4, 5]
        var empty = numbers
        empty.removeAll()
        XCTAssertEqual(numbers.ip_mostCommonElements(), [6])
        XCTAssertEqual(noMode.ip_mostCommonElements(), noMode)
        XCTAssertEqual(empty.ip_mostCommonElements(), [])
    }
    
    func testContainsAll() {
        let testArray = [1, 5, 9, 14, 12]
        XCTAssert(testArray.ip_containsAll([1, 12]))
        XCTAssertFalse(testArray.ip_containsAll([14, 16]))
        XCTAssertFalse(testArray.ip_containsAll([1, 5, 9, 10]))
    }
    
    func testRemoveElements() {
        var testArray = [1, 5, 9, 14, 12]
        testArray.ip_removeElements([1, 5, 9])
        XCTAssert(testArray == [14, 12])
        
        testArray.ip_removeElements([12])
        XCTAssert(testArray == [14])
    }
    
    func testIndicesOf() {
        let testArray = [4, 8, 15, 16, 23, 42]
        XCTAssert(testArray.ip_indicesOf([4, 16, 42]) == [0, 3, 5])
        XCTAssert(testArray.ip_indicesOf([0, 1, 4]) == [NSNotFound, NSNotFound, 0])
    }
    
    func testSubArrayFromIndicesOf() {
        let testArray = [4, 8, 15, 16, 23, 42]
        let indices = testArray.ip_indicesOf([15, 16, 19])
        let subTestArray = testArray.ip_subArrayFromIndices(indices)
        XCTAssert(subTestArray == [15, 16])
    }
    
}
