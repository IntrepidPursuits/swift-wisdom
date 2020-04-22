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

    func test_ip_fromNib_returnsCorrectViewType() {
        let testView = TestView.ip_fromNib(in: bundle)
        XCTAssert(testView.isKind(of: TestView.self))
    }
}
