//
//  String+Substrings.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/27/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import Foundation

public extension String {
    // TODO: Need to write tests for this

    public subscript(range: Range<Int>) -> String {
        let chars = Array(characters)
        let substringCharacters = chars[range]
        return String(substringCharacters)
    }

    public subscript(range: CountableClosedRange<Int>) -> String {
        let chars = Array(characters)
        let substringCharacters = chars[range]
        return String(substringCharacters)
    }

    public mutating func dropFirst() {
        guard !isEmpty else { return }
        self = self[1..<characters.count]
    }

    // From http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index/32379600#32379600
    func ip_range(fromNSRange nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }

    // TODO: consider naming 'unchecked'
    func ip_range(from range: ClosedRange<Int>) -> Range<String.Index> {
        let from = index(startIndex, offsetBy: range.lowerBound)
        let to = index(startIndex, offsetBy: range.count)
        return from..<to
    }
}
