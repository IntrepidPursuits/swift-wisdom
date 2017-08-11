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
    static func + (lhs: Self, rhs: Self) -> Self
    static func / (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    init(_ int: Int64)
}

extension Mathable {
    public static var zero: Self {
        return self.init(Int64(0))
    }
}

extension Collection where Element: Mathable {
    public func ip_mean() -> Element {
        let zero = Iterator.Element.zero
        let count = Iterator.Element(Int64(self.count))
        guard count > zero else { return zero }
        return reduce(zero, +) / count
    }

    public func ip_median() -> Element {
        let zero = Iterator.Element.zero
        let count = Iterator.Element(Int64(self.count))
        guard count > zero else { return zero }
        return sorted(by: <).ip_middleElements.ip_mean()
    }

    public func ip_mode() -> [Element] {
        return ip_mostCommonElements()
    }
}

public func avg<T: Mathable>(of numbers: T...) -> T? {
    return avg(of: numbers)
}

public func avg<T: Mathable>(of numbers: [T]) -> T? {
    return numbers.ip_mean()
}

extension Int: Mathable {}
extension Float: Mathable {}
extension Double: Mathable {}
extension CGFloat: Mathable {}
extension UInt: Mathable {}
extension UInt8: Mathable {}
extension UInt16: Mathable {}
extension UInt32: Mathable {}
extension UInt64: Mathable {}
extension Int8: Mathable {}
extension Int16: Mathable {}
extension Int32: Mathable {}
extension Int64: Mathable {}
