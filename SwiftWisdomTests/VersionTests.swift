//
//  VersionTests.swift
//  bmap
//
//  Created by Logan Wright on 12/8/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class VersionTests: XCTestCase {
    func testVersions() {
        let lowest = Version(string: "0.1.25")!
        XCTAssert(lowest.major == 0)
        XCTAssert(lowest.minor == 1)
        XCTAssert(lowest.patch == 25)

        let middle = Version(string: "1.5.0")!
        XCTAssert(middle.major == 1)
        XCTAssert(middle.minor == 5)
        XCTAssert(middle.patch == 0)
        
        let highest = Version(string: "1.5.13")!
        XCTAssert(highest.major == 1)
        XCTAssert(highest.minor == 5)
        XCTAssert(highest.patch == 13)
        
        XCTAssert(lowest < middle)

        let alsoMiddle = middle
        XCTAssert(alsoMiddle == middle)
        XCTAssert(alsoMiddle <= middle)
        XCTAssert(alsoMiddle >= middle)
        
        XCTAssert(highest > middle)
    }
    
    func testVersionLessThan() {
        let pairs: [(greater: String, lesser: String)] = [
            ("1.0.0", "0.5.2"),
            ("0.3.1", "0.3.0"),
            ("0.0.1", "0.0.0"),
            ("0.2.1", "0.1.5")
        ]
        pairs
            .map { return (Version(string: $0)!, Version(string: $1)!) }
            .forEach { greater, lesser in
                XCTAssertFalse(greater < lesser)
            }
    }
    
    func testVersionGreaterThan() {
        
        let pairs: [(lesser: String, greater: String)] = [
            ("0.5.0", "1.3.2"),
            ("0.1.5", "0.1.7"),
            ("0.0.1", "0.1.0"),
            ("0.2.1", "0.2.2")
        ]
        
        pairs
            .map { return (Version(string: $0)!, Version(string: $1)!) }
            .forEach { lesser, greater in
                XCTAssertFalse(lesser > greater)
            }
    }
    
    func testVersionInitializer() {
        XCTAssertNil(Version(string: "Jibberish"))
    }
}
