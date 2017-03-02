import XCTest
@testable import SwiftWisdom

class ColorDescriptorTests: XCTestCase {
    
    func testFloats() {
        let descriptor: ColorDescriptor = ".3,0.24,0.5,0.1"
        let color = UIColor(red: 0.3, green: 0.24, blue: 0.5, alpha: 0.1)
        XCTAssert(descriptor.color == color)
        XCTAssert(descriptor.rawValue == "0.3,0.24,0.5,0.1")
    }
    
    func test255() {
        let descriptor: ColorDescriptor = "123,234,23,253"
        let color = UIColor(red: 123 / 255, green: 234 / 255, blue: 23 / 255, alpha: 253 / 255)
        XCTAssert(descriptor.color == color)
    }
    
    func testIpHex() {
        XCTAssert(UIColor(ip_hex: "#FFFFFF") == UIColor(red: 1, green: 1, blue: 1, alpha: 1))
        XCTAssert(UIColor(ip_hex: "#00FFFF") == UIColor(red: 0, green: 1, blue: 1, alpha: 1))
        XCTAssert(UIColor(ip_hex: "#FF00FF") == UIColor(red: 1, green: 0, blue: 1, alpha: 1))
        XCTAssert(UIColor(ip_hex: "#FFFF00") == UIColor(red: 1, green: 1, blue: 0, alpha: 1))
    }
    
    func testStringInit() {
        let whiteDescriptor: ColorDescriptor = "#FFFFFF"
        let redDescriptor: ColorDescriptor = "#FF0000"
        let blueDescriptor: ColorDescriptor = "#0000FF"
        let greenDescriptor: ColorDescriptor = "#00FF00"
        
        XCTAssert(whiteDescriptor.color == UIColor(red: 1, green: 1, blue: 1, alpha: 1));
        XCTAssert(blueDescriptor.color == UIColor(red: 0, green: 0, blue: 1, alpha: 1));
        XCTAssert(redDescriptor.color == UIColor(red: 1, green: 0, blue: 0, alpha: 1));
        XCTAssert(greenDescriptor.color == UIColor(red: 0, green: 1, blue: 0, alpha: 1));
    }
    
    func testEqualityBetweenColors() {
        let lhs: ColorDescriptor = "123,234,23,253"
        let rhs: ColorDescriptor = "123,234,23,253"
        XCTAssert(lhs == rhs)
        
        let lhsHexDescriptor: ColorDescriptor = "#0000FF"
        let rhsHexDescriptor: ColorDescriptor = "#FF0000"
        XCTAssertFalse(lhsHexDescriptor == rhsHexDescriptor)
        
        let whiteHexDescriptor: ColorDescriptor = "#FFFFFF"
        let whiteRGBHexDescriptor: ColorDescriptor = "255,255,255,255"
        XCTAssertFalse(whiteHexDescriptor == whiteRGBHexDescriptor)
    }
    
    func testUnicodeScalarColor() {
        let color: ColorDescriptor = ColorDescriptor.init(unicodeScalarLiteral: "#0000FF")
        XCTAssert(color.color == UIColor(red: 0, green: 0, blue: 1, alpha: 1))
    }
    
    func testStringLiteralColor() {
        let color: ColorDescriptor = ColorDescriptor.init(stringLiteral: "#0000FF")
        XCTAssert(color.color == UIColor(red: 0, green: 0, blue: 1, alpha: 1))
    }
    
    func testExtendedGraphemeClusterLiteralColor() {
        let color: ColorDescriptor = ColorDescriptor.init(extendedGraphemeClusterLiteral: "#0000FF")
        XCTAssert(color.color == UIColor(red: 0, green: 0, blue: 1, alpha: 1))
    }
    
    func testRawValueColor() {
        let color: ColorDescriptor? = ColorDescriptor.init(rawValue: "#FF0000")
        XCTAssertNotNil(color)
        XCTAssert(color?.color == UIColor(red: 1, green: 0, blue: 0, alpha: 1))
    }
}
