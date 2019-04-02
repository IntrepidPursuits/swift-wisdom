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

public protocol DataConvertible: ExpressibleByIntegerLiteral {
    init?(ip_data: Data)
    var ip_data: Data { get }
}

extension DataConvertible {

    public init?(ip_data data: Data) {
        let size = MemoryLayout<Self>.size
        var value: Self = 0
        if data.count < size {
            let emptyBytes: [UInt8] = Array(repeating: 0, count: size - data.count)
            let modifiedData = data + emptyBytes
            _ = withUnsafeMutableBytes(of: &value) { modifiedData.copyBytes(to: $0) }
            self = value
        } else if data.count == size {
            _ = withUnsafeMutableBytes(of: &value) { data.copyBytes(to: $0) }
            self = value
        } else {
            return nil
        }
    }

    public var ip_data: Data {
        var copy = self
        return Data(bytes: &copy, count: MemoryLayout<Self>.size)
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
extension UInt: DataConvertible {}
extension UInt8: DataConvertible {}
extension UInt16: DataConvertible {}
extension UInt32: DataConvertible {}
extension UInt64: DataConvertible {}
