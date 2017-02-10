//
//  QuTests.swift
//  SwiftWisdom
//
//  Created by Colden Prime on 2/2/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class QuTests: XCTestCase {
    func testMainExecutesClosureOnMainThread() {
        let mainExpectation = expectation(description: "Calling Qu.Main should call a block on the main thread")

        _ = Qu.Main {
            if Thread.current.isMainThread {
                mainExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testBackgroundExecutesClosureOffOfMainThread() {
        let backgroundExpectation = expectation(description: "Calling Qu.Background should call a block off of main thread")

        _ = Qu.Background {
            if !Thread.current.isMainThread {
                backgroundExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFinallyOnMainExecutesClosureOnMainThread() {
        let backgroundExpectation = expectation(description: "Calling Qu.Background should call a block off of main thread")
        let mainExpectation = expectation(description: "Calling .FinallyOn(.main) should call a block on the main thread")

        Qu.Background {
            if !Thread.current.isMainThread {
                backgroundExpectation.fulfill()
            }
        }.FinallyOn(.main) {
            if Thread.current.isMainThread {
                mainExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
