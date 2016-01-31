//
//  ColorDescriptorTests.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/30/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class ColorDescriptorTests: XCTestCase {
    
    func testFloats() {
        let descriptor: ColorDescriptor = ".3,0.24,0.5,0.1"
        let color = UIColor(red: 0.3, green: 0.24, blue: 0.5, alpha: 0.1)
        XCTAssert(descriptor.color == color)
    }
    
    func test255() {
        let descriptor: ColorDescriptor = "123,234,23,253"
        let color = UIColor(red: 123 / 255, green: 234 / 255, blue: 23 / 255, alpha: 253 / 255)
        XCTAssert(descriptor.color == color)
    }
    
    func testHex() {
        let hex = "#4fdac1"
        let descriptor = ColorDescriptor(hex)
        let color = UIColor(ip_hex: hex)
        XCTAssert(descriptor.color == color)
    }
}
