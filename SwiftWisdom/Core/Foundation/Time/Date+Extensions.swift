//
//  Date+Extensions.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 1/28/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

public extension Date {

    static var ip_millisecondFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "Y-MM-dd HH:mm:ss.SSSS"
        return formatter
    }

    static var ip_longDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .long // Ex: January 14, 2015
        return formatter
    }

    static var ip_shortDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "M.d.yyyy"
        return formatter
    }

    static var ip_timeStampFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "M.d.yyy h:mm a"
        return formatter
    }

    /// Returns a full timestamp with milliseconds
    var ip_millisecondTimeStampString: String {
        return Date.ip_millisecondFormatter.string(from: self)
    }

    /// Returns a string in the long date format, ex: January 14, 2015
    var ip_longDateString: String {
        return Date.ip_longDateFormatter.string(from: self)
    }

    /// Returns a string in the short date format, ex: 1/14/2015
    var ip_shortDateString: String {
        return Date.ip_shortDateFormatter.string(from: self)
    }

    /// Returns a full timestamp for the current timezone
    var ip_timeStampString: String {
        return Date.ip_timeStampFormatter.string(from: self)
    }
}
