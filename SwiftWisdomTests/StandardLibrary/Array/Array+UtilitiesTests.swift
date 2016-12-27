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

    func testChunks() {
        let testArray = [0, 1, 2, 3, 4, 5, 6, 7]

        var chunks = testArray.ip_chunks(of: 0)
        XCTAssert(chunks.count == 1 && chunks.first ?? [] == testArray)

        chunks = testArray.ip_chunks(of: 0, includeRemainder: false)
        XCTAssert(chunks.isEmpty)

        chunks = testArray.ip_chunks(of: 100)
        XCTAssert(chunks.count == 1 && chunks.first ?? [] == testArray)

        chunks = testArray.ip_chunks(of: 100, includeRemainder: false)
        XCTAssert(chunks.isEmpty)

        chunks = testArray.ip_chunks(of: 2)
        XCTAssert(chunks.count == 4)
        XCTAssert(chunks[0] == [0, 1])
        XCTAssert(chunks[1] == [2, 3])
        XCTAssert(chunks[2] == [4, 5])
        XCTAssert(chunks[3] == [6, 7])

        chunks = testArray.ip_chunks(of: 3)
        XCTAssert(chunks.count == 3)
        XCTAssert(chunks[0] == [0, 1, 2])
        XCTAssert(chunks[1] == [3, 4, 5])
        XCTAssert(chunks[2] == [6, 7])

        chunks = testArray.ip_chunks(of: 3, includeRemainder: false)
        XCTAssert(chunks.count == 2)
        XCTAssert(chunks[0] == [0, 1, 2])
        XCTAssert(chunks[1] == [3, 4, 5])

        chunks = [1, 2, 3].ip_chunks(of: 1)
        XCTAssert(chunks.count == 3)
        XCTAssert(chunks[0] == [1])
        XCTAssert(chunks[1] == [2])
        XCTAssert(chunks[2] == [3])

        XCTAssert([].ip_chunks(of: 0).isEmpty)
        XCTAssert([].ip_chunks(of: 1).isEmpty)
    }
}
