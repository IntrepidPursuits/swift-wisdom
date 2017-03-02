//
//  TimeOfDayTests.swift
//  SwiftWisdom
//
//  Created by Patrick Butkiewicz on 3/1/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import Foundation
import XCTest
import SwiftWisdom

final class TimeOfDayTests: XCTestCase {
    // Corresponds to Jan 1st, 2017, 3:16 AM GMT
    private var testSingleHourDigitEpochTime: TimeInterval = 1483240560
    // Corresponds to Jan 1st, 2017, 11:00 AM GMT
    private var testDoubleHourDigitEpochTime: TimeInterval = 1483268400
    
    override func setUp() {
        let offset = TimeZone.current.secondsFromGMT()
        testSingleHourDigitEpochTime -= TimeInterval(offset)
        testDoubleHourDigitEpochTime -= TimeInterval(offset)
    }
    
    func testTimeFromDate() {
        let td1 = TimeOfDay(Date(timeIntervalSince1970: testSingleHourDigitEpochTime))
        XCTAssert(td1?.displayString.compare("3:16 AM") == .orderedSame)
        XCTAssert(td1?.stringRepresentation.compare("03:16") == .orderedSame)
        
        let td2 = TimeOfDay(Date(timeIntervalSince1970: testDoubleHourDigitEpochTime))
        XCTAssert(td2?.displayString.compare("11:00 AM") == .orderedSame)
        XCTAssert(td2?.stringRepresentation.compare("11:00") == .orderedSame)
    }
    
    func testTimeFromString() {
        let td = TimeOfDay("3:16")
        XCTAssert(td?.displayString.compare("3:16 AM") == .orderedSame)
        XCTAssert(td?.stringRepresentation.compare("03:16") == .orderedSame)
        
        let td2 = TimeOfDay("11:00")
        XCTAssert(td2?.displayString.compare("11:00 AM") == .orderedSame)
        XCTAssert(td2?.stringRepresentation.compare("11:00") == .orderedSame)
        
        let td3 = TimeOfDay("16:21")
        XCTAssert(td3?.displayString.compare("4:21 PM") == .orderedSame)
        XCTAssert(td3?.stringRepresentation.compare("16:21") == .orderedSame)
    }
    
    func testNilTimeFromInvalidString() {
        XCTAssertNil(TimeOfDay(""))
    }
    
    func testApplyingTimeToDate() {
        let timeToApply = TimeOfDay(Date(timeIntervalSince1970: testSingleHourDigitEpochTime))
        let receivingDate = Date(timeIntervalSince1970: testDoubleHourDigitEpochTime)
        let newDate = timeToApply?.timeOnDate(receivingDate)
        let newTime = TimeOfDay(newDate!)
        XCTAssert(timeToApply?.minutes == newTime?.minutes)
        XCTAssert(timeToApply?.hours == newTime?.hours)
    }
    
    func testApplyingTimeToToday() {
        let timeToApply = TimeOfDay(Date(timeIntervalSince1970: testSingleHourDigitEpochTime))
        let newDate = timeToApply?.timeToday()
        let newTime = TimeOfDay(newDate!)
        XCTAssert(timeToApply?.minutes == newTime?.minutes)
        XCTAssert(timeToApply?.hours == newTime?.hours)
    }
    
}
