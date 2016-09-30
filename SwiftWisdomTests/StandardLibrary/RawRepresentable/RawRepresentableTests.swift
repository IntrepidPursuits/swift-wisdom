//
//  RawRepresentableTests.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 4/1/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest

class RawRepresentableTests: XCTestCase {
    enum Signed: Int {
        case a, b, c, d, e, f, g
    }
    
    enum Unsigned: UInt {
        case a, b, c, d, e, f, g
    }
    
    enum Typed: UInt8 {
        case a, b, c, d, e, f, g
    }
    
    func testAllCases() {
        let allSigned = Signed.ip_allCases
        XCTAssert(allSigned == [.a, .b, .c, .d, .e, .f, .g])
        let allUnsigned = Unsigned.ip_allCases
        XCTAssert(allUnsigned == [.a, .b, .c, .d, .e, .f, .g])
        let allTyped = Typed.ip_allCases
        XCTAssert(allTyped == [.a, .b, .c, .d, .e, .f, .g])
    }
}
