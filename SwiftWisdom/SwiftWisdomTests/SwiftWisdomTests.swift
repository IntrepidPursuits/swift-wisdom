//
//  SwiftWisdomTests.swift
//  SwiftWisdomTests
//
//  Created by Logan Wright on 11/10/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdomDev

class SwiftWisdomTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
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
