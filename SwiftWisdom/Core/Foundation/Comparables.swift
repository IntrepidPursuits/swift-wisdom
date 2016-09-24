//
//  Comparables.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 7/2/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension Comparable {
    public func ip_constrainBetween(low: Self, high: Self) -> Self {
        var val = Swift.min(self, high)
        val = Swift.max(val, low)
        return val
    }
}
