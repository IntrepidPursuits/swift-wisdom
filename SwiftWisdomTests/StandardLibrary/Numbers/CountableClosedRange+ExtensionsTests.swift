//
//  CountableClosedRange+ExtensionsTests.swift
//  SwiftWisdom
//
//  Created by Andrew Dolce on 11/21/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class CountableClosedRangeExtensionTests: XCTestCase {

    // This test is complex. Here is an explanation as to why:
    //
    // The original goal was to test the public ip_random() function on CountableClosedRange. Previously we had tests
    // that would call ip_random() a few times, and then verify that the output values were contained inside the
    // original range as expected.
    //
    // I've decided to change this approach because:
    //
    // 1. Testing the output of real calls to arc4random_uniform means that the unit test will be non-deterministic, and
    //    therefore could be flaky. What if we had a bug that only occurred with a single specific value of arc4random?
    //    Our test would pass most of the time, but occasionally fail.
    //
    // 2. We're not really interested in testing the behavior of arc4random in the first place, but rather our logic
    //    that sits on top of that function.
    //
    // One approach would be to seed the random number generator with a hard-coded value, but arc4random is not designed
    // to be seedable.
    //
    // Instead I decided to break out an internal version of ip_random that allows the caller to specify a replacement
    // for arc4random_uniform. This way we can mock out the function to return controlled values. The obvious downside
    // is that the test is now somewhat coupled to the implementation, and tests an internal helper instead of the true
    // public interface.

    func testRandomInRange() {
        let lowerBound = -100
        let upperBound = 100
        let testRange = lowerBound...upperBound

        // We do not want to assume that we know the upper bound argument provided to the random number generator
        // function. Instead we will make one call and capture the input.
        var capturedRNGUpperBound: Int? = nil
        let _ = testRange.ip_random(withUniformRNGFunction: { upperBound in
            capturedRNGUpperBound = upperBound
            return 0
        })

        guard let rngUpperBound = capturedRNGUpperBound, rngUpperBound > 0 else {
            XCTAssert(false, "Expected that RNG function upper bound \(capturedRNGUpperBound) is non-nil and positive.")
            return
        }

        // We will test by sampling the ip_random output for every possible mock RNG output within the upper bound.
        // We test that the following assumptions hold true:
        // 1. Each RNG call will be made with the same upper bound value as previously captured. If not, it means that
        //    ip_random is introducing extra non-determinism on top of the RNG function, which is not its job.
        // 2. Each output value of ip_random() should fall within the test range.
        // 3. Every possible value of the test range should be generated at least once, and should be generated the same
        //    number of times as each other value. Otherwise it means we've introduced a bias.
        var frequencyBySample = [Int : Int]()

        for mockRNGValue in 0..<rngUpperBound {
            let sample = testRange.ip_random(withUniformRNGFunction: { upperBound in
                XCTAssertEqual(upperBound, rngUpperBound, "Expected RNG function to be called with a consistent upper bound each time." )
                return mockRNGValue
            })
            XCTAssert(testRange.contains(sample), "Expected random value \(sample) to be contained in the range.")
            frequencyBySample[sample] = (frequencyBySample[sample] ?? 0) + 1
        }

        let frequencyOfLowerBound = frequencyBySample[lowerBound] ?? 0
        XCTAssertGreaterThan(frequencyOfLowerBound, 0, "Expected value \(lowerBound) to be sampled at least once.")

        for possibleSample in testRange {
            XCTAssertEqual(frequencyBySample[possibleSample], frequencyOfLowerBound, "Expected value \(possibleSample) to be sampled exactly \(frequencyOfLowerBound) times.")
        }
    }
}
