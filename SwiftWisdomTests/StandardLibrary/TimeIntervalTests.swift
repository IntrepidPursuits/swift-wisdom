//
//  TimeIntervalTests.swift
//  SwiftWisdomTests
//
//  Created by Bob Gilmore on 1/3/18.
//  Copyright © 2018 Intrepid. All rights reserved.
//

import XCTest
import SwiftWisdom

class TimeIntervalTests: XCTestCase {

    private let secondsPerHour = 60.0 * 60.0
    
    @available(iOS 10.0, *)
    func testTimeIntervalMeasurementInitializer() {
        let hours = 2.0
        let twoHourMeasurement = Measurement(value: hours, unit: UnitDuration.hours)
        let intervalFromSeconds = TimeInterval(hours * secondsPerHour)
        let intervalFromDuration = TimeInterval(twoHourMeasurement)
        XCTAssertEqual(intervalFromDuration, intervalFromSeconds)
    }
}
