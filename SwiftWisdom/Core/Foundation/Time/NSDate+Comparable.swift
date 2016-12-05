//
//  Comparables.swift
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import Foundation

// Date already conforms to comparable. But NSDate does not.

extension NSDate : Comparable {
    @nonobjc public static func < (lhs: NSDate, rhs: NSDate) -> Bool {
        return lhs.timeIntervalSince1970 < rhs.timeIntervalSince1970
    }
    @nonobjc public static func <= (lhs: NSDate, rhs: NSDate) -> Bool {
        return lhs.timeIntervalSince1970 <= rhs.timeIntervalSince1970
    }
    @nonobjc public static func >= (lhs: NSDate, rhs: NSDate) -> Bool {
        return lhs.timeIntervalSince1970 >= rhs.timeIntervalSince1970
    }
    @nonobjc public static func > (lhs: NSDate, rhs: NSDate) -> Bool {
        return lhs.timeIntervalSince1970 > rhs.timeIntervalSince1970
    }
}
