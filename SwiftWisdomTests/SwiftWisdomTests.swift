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

    func testConstraints_TopConstraint() {
        let parent = UIView()
        let child = UIView()
        parent.addSubview(child)
        let vconstraint = NSLayoutConstraint(item: parent,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: child,
                                            attribute: .top,
                                            multiplier: 1,
                                            constant: 165)
        parent.addConstraint(vconstraint)
        let constraint = parent.ip_constraintForAttribute(.top, onView: nil, toView: child, viewAttribute: .top)
        XCTAssertEqual(constraint?.constant, 165, "Constraint is nil or constant does not match expected")
    }
    
    func testConstraints_NoConstraint() {
        let parent = UIView()
        let child = UIView()
        parent.addSubview(child)
        let constraint = parent.ip_constraintForAttribute(.bottom, onView: nil, toView: child, viewAttribute: .top)
        XCTAssertNil(constraint, "Constraint found, expected nil constraint")
    }
}
