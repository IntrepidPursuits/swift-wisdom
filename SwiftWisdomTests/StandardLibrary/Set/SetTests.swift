//
//  SetTests.swift
//  SwiftWisdom
//
//  Created by Patrick Butkiewicz on 3/1/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import Foundation
import XCTest

final class SetTests: XCTestCase {
    private let evenSet = Set(arrayLiteral: 2, 4, 6, 8)
    
    func testSetToArray() {
        let setToArray = evenSet.ip_toArray()
        XCTAssert(setToArray.count == evenSet.count)
    }
}
