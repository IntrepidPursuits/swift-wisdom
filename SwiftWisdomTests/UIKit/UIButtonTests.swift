//
//  UIButtonTests.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 3/20/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import UIKit
import SwiftWisdom
import XCTest

final class UIButtonTests: XCTestCase {
    
    func testEditAttributedTitle() {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.ip_editAttributedTitle("CANCEL", useSpacing: 2.0, forState: .normal)
        
        let attributes = button.attributedTitle(for: .normal)?.attributes(at: 0, effectiveRange: nil)
        XCTAssert(attributes?[NSKernAttributeName] as? CGFloat == 2.0)
        XCTAssert(attributes?[NSForegroundColorAttributeName] as? UIColor == .blue)
    }

}
