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
}

extension CollectionType where Generator.Element: Mathable {
    
    public func ip_average() -> Generator.Element? {
        return ip_mean()
    }
    
    public func ip_mean() -> Generator.Element? {
        // Maybe this should just spit back a float?
        let zero = Generator.Element(0.toIntMax())
        let count = Generator.Element(self.count.toIntMax())
        guard count > zero else { return nil }
        return reduce(zero, combine: +) / count
    }
    
    public func ip_median() -> Generator.Element? {
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
extension Float80: Mathable {}
// Any other number types we should include?
