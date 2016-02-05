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
}
