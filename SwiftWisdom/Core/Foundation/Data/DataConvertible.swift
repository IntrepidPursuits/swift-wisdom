//
//  DataConvertible.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 2/3/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//
//  Protocol adapted from http://stackoverflow.com/questions/38023838/round-trip-swift-number-types-to-from-data

import Foundation
import UIKit

public protocol DataConvertible {
    init?(ip_data: Data)
    var ip_data: Data { get }
}

extension DataConvertible {
    
    public init?(ip_data data: Data) {
        guard data.count == MemoryLayout<Self>.size else { return nil }
        self = data.withUnsafeBytes { $0.pointee }
    }
    
    public var ip_data: Data {
        var value = self
        return Data(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
}

extension Float: DataConvertible {}
extension Double: DataConvertible {}
extension CGFloat: DataConvertible {}
extension Int: DataConvertible {}
extension Int8: DataConvertible {}
extension Int16: DataConvertible {}
extension Int32: DataConvertible {}
extension Int64: DataConvertible {}
// UnsignedIntegers are covered by UnsignedInteger+Extensions.swift (without optional init)
