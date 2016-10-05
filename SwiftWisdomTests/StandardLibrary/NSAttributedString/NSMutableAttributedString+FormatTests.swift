//
//  NSMutableAttributedString+FormatTests.swift
//  SwiftWisdom
//
//  Created by Ying Quan Tan on 9/30/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

class NSMutableAttributedString_FormatTests: XCTestCase {

    func testip_formatSetStrings() {
        let subject = NSMutableAttributedString(string: "%@%@")
        subject.ip_format(withArguments: [NSAttributedString(string: "hello"),
                                          NSAttributedString(string: "world")])

        XCTAssert(subject.string == "helloworld")
    }

    func testip_formatSetsAttributes() {
        let hello = NSAttributedString(string: "hello", attributes: [NSForegroundColorAttributeName: UIColor.red])
        let world = NSAttributedString(string: "world", attributes: [NSForegroundColorAttributeName: UIColor.blue])
        let subject = NSMutableAttributedString(string: "%@%@")
        subject.ip_format(withArguments: [hello, world])
        XCTAssert(subject.foregroundColorAttribute(atIndex: 0) == UIColor.red)
        XCTAssert(subject.foregroundColorAttribute(atIndex: 5) == UIColor.blue)
    }

    func testInitFormatStringAttributesArgumentsShouldSetAttributes() {
        let subject = NSMutableAttributedString(formatString: "%@%@",
                                                attributes: [NSForegroundColorAttributeName : UIColor.blue],
                                                arguments: "hello", "world")
        XCTAssert(subject.foregroundColorAttribute(atIndex: 0) == UIColor.blue)
    }
}

// test helpers
fileprivate extension NSMutableAttributedString {

    func foregroundColorAttribute(atIndex index: Int) -> UIColor {
        let dict = attributes(at: index, effectiveRange: nil)
        return dict[NSForegroundColorAttributeName] as! UIColor
    }

}
