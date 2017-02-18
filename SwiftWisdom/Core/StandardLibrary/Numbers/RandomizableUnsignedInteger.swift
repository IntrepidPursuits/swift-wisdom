//
//  RandomizableUnsignedInteger.swift
//  SwiftWisdom
//
//  Created by Andrew Dolce on 2/17/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import Foundation

public protocol RandomizableUnsignedInteger: UnsignedInteger {
    static func ip_random() -> Self
}

extension RandomizableUnsignedInteger {
    public static func ip_random() -> Self {
        let upperBound = UInt32(ip_maxValue.toUIntMax())
        return self.init(arc4random_uniform(upperBound).toUIntMax())
    }
}

// The preferred way to generate random numbers in Swift without bias is via arc4random_uniform, which is only
// able to generate random numbers for 32 bits or less. So until we find a better way, we explicitly do not support
// random number generation for UInt64.

extension UInt8: RandomizableUnsignedInteger {}
extension UInt16: RandomizableUnsignedInteger {}
extension UInt32: RandomizableUnsignedInteger {}
