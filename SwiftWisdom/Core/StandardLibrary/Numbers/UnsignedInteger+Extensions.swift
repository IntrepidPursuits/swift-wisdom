//
//  UnsignedInteger+Extensions.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension UnsignedInteger {
    public static func ip_random() -> Self {
        let intMax = Int(ip_maxValue.toIntMax())
        let rand = random(inRange: 0...intMax)
        return self.init(ip_safely: rand)
    }
}

// TODO: evaluate whether we should move random to be a member of CountableClosedRange
public func random(inRange range: CountableClosedRange<Int>) -> Int {
    let diff = range.upperBound - range.lowerBound
    let randomOffset = Int(arc4random_uniform(UInt32(diff + 1)))
    let random = range.lowerBound + randomOffset
    return random
}

// TODO: write tests for this extension
extension UnsignedInteger {

    public func ip_containsBitMask(_ bitMask: Self) -> Bool {
        return (self & bitMask) == bitMask
    }

    /// Converts a bit mask into its given indexes. For example, `0b101` will return `[0,2]`
    public var ip_maskedIndexes: [Self] {
        var copy = self
        var currentIndex: Self = 0
        var selectedIndexes: [Self] = []
        while copy > 0 {
            if copy.ip_containsBitMask(1) {
                selectedIndexes.append(currentIndex)
            }
            // >> 1
            copy = copy / 2
            currentIndex = currentIndex + 1
        }
        return selectedIndexes
    }

    public func ip_containsMask(_ mask: Self) -> Bool {
        return (self & mask) == mask
    }
}

// TODO: write tests for this extension
extension UnsignedInteger {
    public static var ip_maxValue: Self {
        return ip_bitStackOfLength(ip_maximumNumberOfBits)
    }

    public static var ip_maximumNumberOfBits: Int {
        return MemoryLayout<Self>.size * 8
    }

    /**
     * Returns a type with a particular bit pattern of ones. 
     *
     * If length > MemoryLayout<Self>.size, the function computes 
     * ip_bitStackOfLength(MemoryLayout<Self>.size). If length <= 0, the function computes
     * ip_bitStackOfLength(0)
     *
     * Example:                         Corresponding Memory Layout
     * UInt8.ip_bitStackOfLength(2)        | 0 0 0 0 0 0 1 1 |
     * UInt8.ip_bitStackOfLength(3)        | 0 0 0 0 0 1 1 1 |
     *
     * @param length the number of ones in the bit pattern.
     *
     * @return a typed bit pattern
     */
    public static func ip_bitStackOfLength(_ length: Int) -> Self {
        let maxLength = ip_maximumNumberOfBits
        guard length > 0 else { return Self(0) }
        guard length <= maxLength else { return ip_bitStackOfLength(maxLength) }

        var stack: Self = 0
        for _ in 1...length {
            // stack <<= 1
            stack = stack * 2
            // stack |= 1
            stack = stack + 1
        }
        return stack
    }
}

// TODO: write tests for this extension
extension UnsignedInteger {
    public init<T: SignedInteger>(ip_safely value: T) {
        if value < 0 {
            self.init(ip_safely: UInt8(0))
        } else {
            let max = UIntMax(value.toIntMax())
            self.init(ip_safely: max)
        }
    }

    public init<T: UnsignedInteger>(ip_safely value: T) {
        self = 0

        let maxSelf = type(of: self).ip_maxValue
        if maxSelf.toUIntMax() >= value.toUIntMax() {
            self = .init(value.toUIntMax())
        } else {
            self = maxSelf
        }
    }
}

extension UInt16 {
    public var ip_bigEndianData: Data {
        return CFSwapInt16HostToBig(self).ip_data
    }

    public var ip_littleEndianData: Data {
        return CFSwapInt16HostToLittle(self).ip_data
    }
}

extension UInt32 {
    public var ip_bigEndianData: Data {
        return CFSwapInt32HostToBig(self).ip_data
    }

    public var ip_littleEndianData: Data {
        return CFSwapInt32HostToLittle(self).ip_data
    }
}

extension UInt64 {
    public var ip_bigEndianData: Data {
        return CFSwapInt64HostToBig(self).ip_data
    }

    public var ip_littleEndianData: Data {
        return CFSwapInt64HostToLittle(self).ip_data
    }
}
