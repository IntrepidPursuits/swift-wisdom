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
        let constraint = vc?.view.ip_constraintForAttribute(.top, onView: nil, toView: vc?.blueView, viewAttribute: .top)
        XCTAssertEqual(constraint?.constant, 165, "Top constraint found with nil view")
    }
    
    func testConstraints_NoConstraint() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController
        let constraint = vc?.view.ip_constraintForAttribute(.bottom, onView: nil, toView: vc?.blueView, viewAttribute: .top)
        XCTAssertNil(constraint, "No constraint there")
    }
}

class NSMutableAttributedStringTests: XCTestCase {
    func testAttributedStringApplyingAttributes() {
        let redText = AttributedString(
            string: "RED",
            attributes: [NSForegroundColorAttributeName : UIColor.red()]
        )
        let testString = NSMutableAttributedString(stringWithFormat: "This color is %@", redText)
        let otherTestString = NSMutableAttributedString(
            stringWithFormat: "This color is %@",
            applyingAttributes: [NSForegroundColorAttributeName : UIColor.red],
            toArgs: "RED"
        )
        let blueTestString = NSMutableAttributedString(
            stringWithFormat: "This color is %@",
            applyingAttributes: [NSForegroundColorAttributeName : UIColor.blue],
            toArgs: "RED"
        )
        
        XCTAssertEqual(testString, otherTestString)
        XCTAssertNotEqual(otherTestString, blueTestString)
    }
    
    func testAttributedStringWithFormat() {
        let redText = AttributedString(
            string: "RED",
            attributes: [NSForegroundColorAttributeName : UIColor.red()]
        )
        let testString = NSMutableAttributedString(stringWithFormat: "Color: %@", redText)
        let rangeOfRED = NSRange(location: 7, length: 3)
        XCTAssertEqual(testString.attributedSubstring(from: rangeOfRED), redText)
    }
}
