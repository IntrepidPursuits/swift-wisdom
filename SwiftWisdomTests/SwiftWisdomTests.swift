//
//  SwiftWisdomTests.swift
//  SwiftWisdomTests
//
//  Created by Logan Wright on 11/10/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class StringLocalizationTests: XCTestCase {
    func testLocalizedStringInterpolation() {
        XCTAssertEqual("This argument is the word elephant: %@".ip_localized(["elephant"]), "This argument is the word elephant: elephant")
    }
}

class GetConstraintTests: XCTestCase {
    func testConstraints_NilToView() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController
        let constraint = vc?.view.ip_constraintForAttribute(.Top, onView: nil, toView: vc?.blueView, viewAttribute: .Top)
        XCTAssertEqual(constraint?.constant, 165, "Top constraint found with nil view")
    }
    
    func testConstraints_NoConstraint() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController
        let constraint = vc?.view.ip_constraintForAttribute(.Bottom, onView: nil, toView: vc?.blueView, viewAttribute: .Top)
        XCTAssertNil(constraint, "No constraint there")
    }
}
