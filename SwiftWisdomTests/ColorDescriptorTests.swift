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
    
    func testIpHex() {
        XCTAssert(UIColor(ip_hex: "#FFFFFF") == UIColor(red: 1, green: 1, blue: 1, alpha: 1))
        XCTAssert(UIColor(ip_hex: "#00FFFF") == UIColor(red: 0, green: 1, blue: 1, alpha: 1))
        XCTAssert(UIColor(ip_hex: "#FF00FF") == UIColor(red: 1, green: 0, blue: 1, alpha: 1))
        XCTAssert(UIColor(ip_hex: "#FFFF00") == UIColor(red: 1, green: 1, blue: 0, alpha: 1))
    }
}
