//
//  GeometryTests.swift
//  SwiftWisdom
//
//  Created by Alexander Persian on 12/29/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class GeometryTests: XCTestCase {

    func testIpRadiansInt() {
        let testingAngle: Int = 90
        let result = CGFloat(90.0 * (.pi / 180.0))
        let rads = testingAngle.ip_radians
        XCTAssertEqual(rads, result)
    }

    func testIpRadiansCGFloat() {
        let testingAngle: CGFloat = 90
        let result = CGFloat(90.0 * (.pi / 180.0))
        let rads = testingAngle.ip_radians
        XCTAssertEqual(rads, result)
    }

    func testIpDegrees() {
        let testingRadians: CGFloat = 2
        let result = CGFloat(2.0 * (180.0 / .pi))
        let degrees = testingRadians.ip_degrees
        XCTAssertEqual(degrees, result)
    }

    func testIpSquared() {
        let testNumber: CGFloat = 9.0
        let result: CGFloat = 81.0
        let square = testNumber.ip_squared
        XCTAssertEqual(square, result)
    }

    func testIpComplementOfPercent() {
        let testPercent: CGFloat = 0.35
        let complement = testPercent.ip_complementOfPercentage
        XCTAssertEqual(complement, 0.65)
        
        let negTest: CGFloat = -0.35
        XCTAssert(negTest.ip_complementOfPercentage == 1.35)
        
        let overOne: CGFloat = 1.35
        XCTAssertEqual(overOne.ip_complementOfPercentage, -0.35, accuracy: 0.0001)
    }

    func testIpAngleTo() {
        let originPoint = CGPoint(x: 10.0, y: 10.0)
        let testPoint = CGPoint(x: 30.0, y: 30.0)
        let angle = originPoint.ip_angle(to: testPoint)
        XCTAssertEqual(angle, 45.0, accuracy: 0.01)
    }

    func testIpDistanceTo() {
        let originPoint = CGPoint(x: 5.0, y: 1.0)
        let testPoint = CGPoint(x: 1.0, y: -2.0)
        let distance = originPoint.ip_distance(to: testPoint)
        XCTAssertEqual(distance, CGFloat(5.0))
    }

    func testCircumferenceForRadius() {
        let testRadius: CGFloat = 30.0
        let circumference = circumferenceForRadius(testRadius)
        XCTAssertEqual(circumference, 188.49, accuracy: 0.01)
    }

    func testLengthOfArcForDegrees() {
        let testDegrees: CGFloat = 45.0
        let testRadius: CGFloat = 30.0
        let length = lengthOfArcForDegrees(testDegrees, radius: testRadius)
        XCTAssertEqual(length, 23.56, accuracy: 0.01)
    }

    func testDegreesForLengthOfArc() {
        let testLength: CGFloat = 23.56
        let testRadius: CGFloat = 30.0
        let degrees = degreesForLengthOfArc(testLength, radius: testRadius)
        XCTAssertEqual(degrees, 45.0, accuracy: 0.01)
    }

    func testPointWithCenter() {
        let testCenter = CGPoint(x: 20.0, y: 20.0)
        let testRadius: CGFloat = 30.0
        let testDegrees: CGFloat = 90.0
        let point = pointWithCenter(testCenter, radius: testRadius, angleDegrees: testDegrees)
        XCTAssertEqual(point.x, 20.0, accuracy: 0.01)
        XCTAssertEqual(point.y, 50.0, accuracy: 0.01)
    }
}
