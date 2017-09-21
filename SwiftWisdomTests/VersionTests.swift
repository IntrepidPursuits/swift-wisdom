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
            ("0.2.1", "0.1.5"),
            ("1.2.0-beta.3", "1.2.0-beta.2"),
            ("1.2.0", "1.2.0-beta.2"),
            ("1.2.0-beta", "1.2.0-alpha"),
            ("1.2.3-1+abc" , "1.2.3-1+def") // These are undefined. Should pass.
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
            ("0.2.1", "0.2.2"),
            ("1.2.300000", "12.0.0"),
            ("1.2.0-beta.1", "1.2.0-beta.2"),
            ("1.2.0-alpha", "1.2.0-beta"),
            ("1.2.0-beta.1", "1.2.0"),
            ("1.2.3-1+abc" , "1.2.3-1+def") // These are undefined. Should pass.
        ]
        pairs
            .map { return (Version(string: $0)!, Version(string: $1)!) }
            .forEach { lesser, greater in
                XCTAssertFalse(lesser > greater)
            }
    }
    
    func testVersionInitializer() {
        XCTAssertNil(Version(string: "Jibberish"))
        XCTAssertNil(Version(string: "..."))
        XCTAssertNil(Version(string: "4.jibberish"))
        XCTAssertNil(Version(string: "4.2.jibberish"))
        XCTAssertNil(Version(string: "4.0-pre+meta"))
        XCTAssertNil(Version(string: "4.0.-pre+meta"))
        XCTAssertNil(Version(string: "4.0."))
        XCTAssertNil(Version(string: "4.0.1-"))
        XCTAssertNil(Version(string: "4.0.1-+"))
        XCTAssertNil(Version(string: "4.0.1+"))
        XCTAssertNil(Version(string: "4.0.1.2.3+"))

        XCTAssertEqual(Version(string: "4")?.description, "4.0.0")
        XCTAssertEqual(Version(string: "4.2")?.description, "4.2.0")
        XCTAssertEqual(Version(string: "1.2.3.4.5.6")?.description, "1.2.3")
        XCTAssertEqual(Version(string: "4.0.0000001")?.description, "4.0.1")

        XCTAssertEqual(Version(string: "1.2.3.4-beta2+meta1")?.description, "1.2.3-beta2+meta1")
        XCTAssertEqual(Version(string: "1.2.3-beta4+abcdefg")?.description, "1.2.3-beta4+abcdefg")
    }

    func testPreReleaseAndMetaData() {
        XCTAssertEqual(Version(string: "1.2.3-beta.4")?.preRelease, "beta.4")
        XCTAssertEqual(Version(string: "1.2.3-beta.5+sha.43")?.preRelease, "beta.5")
        XCTAssertEqual(Version(string: "1.2.3-beta.5+sha.43")?.metaData, "sha.43")
        XCTAssertEqual(Version(string: "1.2.3+sha.43")?.metaData, "sha.43")
        XCTAssertEqual(Version(string: "1.2.3--++")?.metaData, "+")
        XCTAssertEqual(Version(string: "1.2.3--++")?.preRelease, "-")
        XCTAssertNil(Version(string: "1.2.3+sha.43")?.preRelease)
    }

    func testEqual() {
        XCTAssertEqual(Version(string: "4.0.0"), Version(string: "4.0.0"))
        XCTAssertNotEqual(Version(string: "4.0.0+meta_info"), Version(string: "4.0.0+other_meta_info"))
        XCTAssert(Version(string: "4") == Version(string: "4.0.0"))
    }

    func testMutatingVersion() {
        var v = Version()
        v.major = 1
        v.minor = 2
        v.patch = 3
        v.preRelease = "testing"
        v.metaData = "sha:abcdefg"
        XCTAssertEqual(v.description, "1.2.3-testing+sha:abcdefg")
        XCTAssertNil(v.originalVersion)
    }
}
