//
//  String+NSRange.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 2/8/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension String {
    // From http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index/32379600#32379600
    public func ip_rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
                return from ..< to
        }
        return nil
    }
}
