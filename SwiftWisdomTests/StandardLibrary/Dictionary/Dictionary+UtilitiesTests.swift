//
//  DictionaryTests.swift
//  SwiftWisdom
//
//  Created by Alexander Persian on 9/30/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation
import XCTest

class DictionaryTests: XCTestCase {

    func testSetValueForKeypath() {
        var testDictionary: Dictionary<String, Int> = [:]
        testDictionary.ip_set(value: 42 as AnyObject, forKeypath: "hello")
        XCTAssertEqual(testDictionary["hello"], 42)
    }

    func testValueForKeypath() {
        let testDictionary = ["answer" : 42]
        let testDictionary2 = ["hello" : ["world" : 102]]
        let result: Int? = testDictionary.ip_value(forKeypath: "answer")
        let result2: Int? = testDictionary2.ip_value(forKeypath: "hello.world")

        XCTAssertEqual(result, 42)
        XCTAssertEqual(result2, 102)
    }
}
