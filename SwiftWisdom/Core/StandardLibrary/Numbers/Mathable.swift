//
//  Mathable.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 2/12/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation
import UIKit

public protocol Mathable: Comparable {
    func + (lhs: Self, rhs: Self) -> Self
    func / (lhs: Self, rhs: Self) -> Self
    func * (lhs: Self, rhs: Self) -> Self
    func - (lhs: Self, rhs: Self) -> Self
    init(_ int: IntMax)
    var doubleValue: Double { get }
}

extension CollectionType where Generator.Element: Mathable {
    
    public func ip_average() -> Double? {
        return ip_mean()
    }
    
    public func ip_mean() -> Double? {
        // Maybe this should just spit back a float?
        let zero = Generator.Element(0.toIntMax())
        let count = Generator.Element(self.count.toIntMax())
        guard count > zero else { return nil }
        return reduce(zero.doubleValue) { $0 + $1.doubleValue } / count.doubleValue
    }
    
    public func ip_median() -> Double? {
        // Maybe this should just spit back a float?
        let zero = Generator.Element(0.toIntMax())
        let count = Generator.Element(self.count.toIntMax())
        guard count > zero else { return nil }
        return self.sort(<).ip_middleValues?.ip_mean()
    }
    
    public func ip_mode() -> [Generator.Element]? {
        return self.ip_mostCommonElements()
    }
}

public func avg<T: Mathable>(numbers: [T]) -> Double? {
    guard numbers.count > 0 else { return nil }
    return (numbers.reduce(T(0), combine: +) / T(numbers.count.toIntMax())).doubleValue
}

extension Int: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension Float: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension Double: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension CGFloat: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension UInt: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension UInt8: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension UInt16: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension UInt32: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension UInt64: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension Int8: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension Int16: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension Int32: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension Int64: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
extension Float80: Mathable {
    public var doubleValue: Double {
        return Double(self)
    }
}
// Any other number types we should include?
