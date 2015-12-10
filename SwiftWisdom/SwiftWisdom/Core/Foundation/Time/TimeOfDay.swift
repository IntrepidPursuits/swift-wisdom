//
//  TimeOfDay.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 11/13/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

/**
 *  A struct represention of dates expressed as a time of day.
 */
public struct TimeOfDay {
    
    // MARK: Public Properties
    
    public let hours: Int
    public let minutes: Int
    
    public var displayFormat: String = "h:mm a" // 9:18 am
    
    // MARK: Readonly
    
    public var stringRepresentation: String {
        var stringRepresentation = hours < 10 ? "0" : ""
        stringRepresentation += "\(hours):\(minutes)"
        return stringRepresentation
    }
    
    public var displayString: String {
        // Backing Format
        dateFormatter.dateFormat = "HH:mm"
        guard let date = dateFormatter.dateFromString(stringRepresentation) else {
            return ""
        }

        // Display format
        dateFormatter.dateFormat = displayFormat
        return dateFormatter.stringFromDate(date)
    }
    
    private let dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.locale = NSLocale.currentLocale()
        return dateFormatter
    }()
    
    // MARK: Initialization
    
    public init?(_ stringRepresentation: String) {
        guard let (hours, minutes) = stringRepresentation.ip_hoursAndMinutes() else {
            return nil
        }
        self.hours = hours
        self.minutes = minutes
    }
    
    public init?(_ date: NSDate) {
        dateFormatter.dateFormat = "HH:mm"
        let formattedStringRepresentation = dateFormatter.stringFromDate(date)
        guard let (hours, minutes) = formattedStringRepresentation.ip_hoursAndMinutes() else {
            return nil
        }
        self.hours = hours
        self.minutes = minutes
    }
    
    // MARK: Date Conversion
    
    public func timeToday() -> NSDate? {
        return timeOnDate(NSDate())
    }
    
    public func timeOnDate(date: NSDate) -> NSDate? {
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: date)
        dateComponents.hour = hours
        dateComponents.minute = minutes
        return calendar.dateFromComponents(dateComponents)
    }
    
}

private extension String {
    func ip_hoursAndMinutes() -> (hours: Int, minutes: Int)? {
        let components = componentsSeparatedByString(":")
        guard
            components.count == 2,
            let hoursString = components.first,
            let minutesString = components.last,
            let hours = Int(hoursString),
            let minutes = Int(minutesString)
            else {
                return nil
            }
        return (hours, minutes)
    }
}