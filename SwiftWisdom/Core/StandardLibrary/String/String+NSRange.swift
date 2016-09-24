//
//  String+NSRange.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 2/8/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

// TODO: collapse with String+Substrings - rename as String+Indexing?
extension String {
    // From http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index/32379600#32379600
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }

    // TODO: Need to write tests for this
    // TODO: consider naming 'unchecked'
    func range(from range: ClosedRange<Int>) -> Range<String.Index> {
        let from = index(startIndex, offsetBy: range.lowerBound)
        let to = index(startIndex, offsetBy: range.count)
        return from..<to
    }
}
