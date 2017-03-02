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
        stringRepresentation += "\(hours):"
        stringRepresentation += (minutes < 10) ? "0" : ""
        stringRepresentation += "\(minutes)"
        return stringRepresentation
    }
    
    public var displayString: String {
        // Backing Format
        dateFormatter.dateFormat = "HH:mm"
        guard let date = dateFormatter.date(from: stringRepresentation) else {
            return ""
        }

        // Display format
        dateFormatter.dateFormat = displayFormat
        return dateFormatter.string(from: date)
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .current
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
    
    public init?(_ date: Date) {
        dateFormatter.dateFormat = "HH:mm"
        let formattedStringRepresentation = dateFormatter.string(from: date)
        guard let (hours, minutes) = formattedStringRepresentation.ip_hoursAndMinutes() else {
            return nil
        }
        self.hours = hours
        self.minutes = minutes
    }
    
    // MARK: Date Conversion
    
    public func timeToday() -> Date? {
        return timeOnDate(Date())
    }
    
    public func timeOnDate(_ date: Date) -> Date? {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.hour = hours
        dateComponents.minute = minutes
        return calendar.date(from: dateComponents)
    }
    
}

private extension String {
    func ip_hoursAndMinutes() -> (hours: Int, minutes: Int)? {
        let components = self.components(separatedBy: ":")
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
