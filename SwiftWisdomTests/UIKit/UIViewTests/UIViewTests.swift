//
//  UIViewTests.swift
//  SwiftWisdomTests
//
//  Created by nathaniel.cox on 1/13/20.
//  Copyright © 2020 Intrepid. All rights reserved.
//

import UIKit
import XCTest
@testable import SwiftWisdom

final class UIViewTests: XCTestCase {
    let bundle = Bundle(for: TestView.self)

    func test_ip_fromNib_returnsNonOptional() {
        let testView = TestView.ip_fromNib(in: bundle)
        XCTAssert(testView is TestView)
    }

    func test_ip_fromNib_returnsOptional() {
        guard let testView = TestView.ip_fromNib(type: TestView.self, in: bundle) else {
            XCTFail("Failed to load from nib")
            return
        }
        XCTAssertNotNil(testView)
    }


}
