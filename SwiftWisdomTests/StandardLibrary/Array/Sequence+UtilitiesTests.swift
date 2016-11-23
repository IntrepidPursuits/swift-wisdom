//
//  SequenceTests.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 3/31/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest

class SequenceTests: XCTestCase {

    func testToArray() {
        XCTAssertEqual([0], (0...0).ip_toArray())
        XCTAssertEqual([0,1], (0...1).ip_toArray())
        XCTAssertEqual([0,1,2,3,4,5,6,7,8,9,10], (0...10).ip_toArray())
        XCTAssertEqual([-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10], (-10...10).ip_toArray())
    }

    func testSplitWithFilter() {
        let (greaterThan50, lessThanOrEqualTo50) = Array(1...100).ip_split(withFilter:  { $0 > 50 })
        XCTAssert(greaterThan50 == Array(51...100))
        XCTAssert(lessThanOrEqualTo50 == Array(1...50))
    }

    func testMostCommonElements() {
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

    func testUniqueValues() {
        let strings = ["b", "b", "a", "v", "v"]
        XCTAssertEqual(strings.ip_uniqueValues(), ["b", "a", "v"])
    }

    func testCountOfElement() {
        let strings = ["b", "b", "b", "v", "v"]
        XCTAssertEqual(strings.ip_count(ofElement: "b"), 3)
    }

    func testContainsAll() {
        let strings = ["b", "b", "a", "v", "v"]
        XCTAssertTrue(strings.ip_contains(all: ["b", "a", "v"]))
    }
}
