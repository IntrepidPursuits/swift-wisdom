//
//  NSMutableAttributedString+FormatTests.swift
//  SwiftWisdom
//
//  Created by Ying Quan Tan on 9/30/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

private let redAttribute = [NSForegroundColorAttributeName : UIColor.red]
private let blueAttribute = [NSForegroundColorAttributeName : UIColor.blue]

class NSMutableAttributedString_FormatTests: XCTestCase {

    func testip_formatSetStrings() {
        let subject = NSMutableAttributedString(string: "%@%@")
        subject.ip_format(withArguments: [NSAttributedString(string: "hello"),
                                          NSAttributedString(string: "world")])

        XCTAssert(subject.string == "helloworld")
    }

    func testip_formatSetsAttributes() {
        let hello = NSAttributedString(string: "hello", attributes: redAttribute)
        let world = NSAttributedString(string: "world", attributes: blueAttribute)
        let subject = NSMutableAttributedString(string: "%@%@")
        subject.ip_format(withArguments: [hello, world])
        XCTAssert(subject.foregroundColorAttribute(atIndex: 0) == UIColor.red)
        XCTAssert(subject.foregroundColorAttribute(atIndex: 5) == UIColor.blue)
    }

    func testInitFormatStringAttributesArgumentsShouldSetAttributes() {
        let subject = NSMutableAttributedString(formatString: "%@%@",
                                                attributes: blueAttribute,
                                                arguments: "hello", "world")
        XCTAssert(subject.foregroundColorAttribute(atIndex: 0) == UIColor.blue)
    }


    func testAttributedStringApplyingAttributes() {
        let redText = NSAttributedString(string: "RED", attributes: redAttribute)
        let testString = NSMutableAttributedString(formatString: "This color is %@",
                                                   arguments: redText)

        let otherTestString = NSMutableAttributedString(formatString: "This color is %@",
                                                        attributes: redAttribute,
                                                        arguments: "RED")

        let blueTestString = NSMutableAttributedString(formatString: "This color is %@",
                                                       attributes: blueAttribute,
                                                       arguments: "RED")
        XCTAssertEqual(testString, otherTestString)
        XCTAssertNotEqual(otherTestString, blueTestString)
    }

    func testAttributedStringWithFormat() {
        let redText = NSAttributedString(string: "RED", attributes: redAttribute)
        let testString = NSMutableAttributedString(formatString: "Color: %@", arguments: redText)
        let rangeOfRED = NSRange(location: 7, length: 3)
        XCTAssertEqual(testString.attributedSubstring(from: rangeOfRED), redText)
    }

}

// test helpers
fileprivate extension NSMutableAttributedString {

    func foregroundColorAttribute(atIndex index: Int) -> UIColor {
        let dict = attributes(at: index, effectiveRange: nil)
        return dict[NSForegroundColorAttributeName] as! UIColor
    }

}
