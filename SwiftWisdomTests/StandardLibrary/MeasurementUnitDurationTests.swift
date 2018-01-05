//
//  MeasurementUnitDuration.swift
//  SwiftWisdomTests
//
//  Created by Bob Gilmore on 1/3/18.
//  Copyright © 2018 Intrepid. All rights reserved.
//

import XCTest

class MeasurementUnitDurationTests: XCTestCase {
    
    private let secondsPerHour = 60.0 * 60.0

    @available(iOS 10.0, *)
    func testMeasurementTimeIntervalInitializer() {
        let hours = 2.0
        let interval = TimeInterval(hours * secondsPerHour)

        let traditionalMeasurement = Measurement(value: hours, unit: UnitDuration.hours)
        let timeIntervalMeasurement = Measurement(value: interval)
        XCTAssertEqual(timeIntervalMeasurement, traditionalMeasurement)
    }
}
