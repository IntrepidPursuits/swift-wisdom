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
    
}
