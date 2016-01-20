//
//  UnsignedInteger+Extensions.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension UnsignedIntegerType {
    public static func ip_random() -> Self {
        let intMax = ip_maxValue.toIntMax()
        let rand = randomInRange(0...Int(intMax))
        return self.init(ip_safely: rand)
    }
}

public func randomInRange(range: Range<Int>) -> Int {
    guard let first = range.first, let last = range.last else { return 0 }
    assert(range.first >= 0)
    let diff = last - first
    let randomOffset = Int(arc4random_uniform(UInt32(diff + 1)))
    let random = first + randomOffset
    return random
}

extension UnsignedIntegerType {
    public init(ip_data: NSData) {
        let hexInt = ip_data.ip_hexInt ?? 0
        self.init(ip_safely: hexInt)
    }
}

extension UnsignedIntegerType {
    public func ip_containsBitMask(bitMask: Self) -> Bool {
        return (self & bitMask) == bitMask
    }
}

extension UnsignedIntegerType {
    
    public var ip_data: NSData {
        var copy = self
        return NSData(bytes: &copy, length: sizeof(Self))
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
}

extension UnsignedIntegerType {
    public static var ip_maxValue: Self {
        return ip_bitStackOfLength(ip_maximumNumberOfBits)
    }
    
    public static var ip_maximumNumberOfBits: Self {
        let size = UIntMax(sizeof(self))
        return Self(size) * 8
    }
    
    public static func ip_bitStackOfLength(length: Self) -> Self {
        let maxLength = ip_maximumNumberOfBits
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

extension UnsignedIntegerType {
    public init<T : SignedIntegerType>(ip_safely value: T) {
        if value < 0 {
            self.init(ip_safely: UInt8(0))
        } else {
            let max = UIntMax(value.toIntMax())
            self.init(ip_safely: max)
        }
    }
    
    public init<T : UnsignedIntegerType>(ip_safely value: T) {
        self = 0
        
        let maxSelf = self.dynamicType.ip_maxValue
        if maxSelf.toUIntMax() >= value.toUIntMax() {
            self = .init(value.toUIntMax())
        } else {
            self = maxSelf
        }
    }
}

extension UnsignedIntegerType {
    public func ip_containsMask(mask: Self) -> Bool {
        return (self & mask) == mask
    }
}

