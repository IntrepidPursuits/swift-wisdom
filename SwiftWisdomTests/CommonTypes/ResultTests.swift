//
//  ResultTests.swift
//  SwiftWisdom
//
//  Created by Patrick Butkiewicz on 3/1/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import Foundation
import SwiftWisdom
import XCTest

class ResultTests: XCTestCase {
    fileprivate enum ResultError: Error { case error }
    private final let successfulResult = IPResult<Int>.success(1)
    private final let failureResult = IPResult<Any>.failure(ResultError.error)
    
    func testSuccessResult() {
        XCTAssert(successfulResult.isSuccess)
        XCTAssertFalse(successfulResult.isFailure)
    }
    
    func testSuccessResultStorage() {
        XCTAssert(successfulResult.value! == 1)
        XCTAssert(try! successfulResult.extract() == 1)
    }
    
    func testSuccessResultErrorIsEmpty() {
        XCTAssertNil(successfulResult.error)
    }
    
    func testFailureResult() {
        XCTAssertFalse(failureResult.isSuccess)
        XCTAssert(failureResult.isFailure)
    }
    
    func testFailureResultStorage() {
        XCTAssertNil(failureResult.value)
        XCTAssertThrowsError(try failureResult.extract())
    }
    
    func testFailureResultErrorExists() {
        XCTAssertNotNil(failureResult.error)
    }
    
}
