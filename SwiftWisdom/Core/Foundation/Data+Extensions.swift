//
//  NSData+Extensions.swift
//  bmap
//
//  Created by Logan Wright on 11/25/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

public extension Data {
    // From here: http://stackoverflow.com/questions/39075043/how-to-convert-data-to-hex-string-in-swift
    public var ip_hexString: String? {
        return map { String(format: "%02hhx", $0) }.joined()
    }
    
    // From here: http://stackoverflow.com/questions/38023838/round-trip-swift-number-types-to-from-data
    public func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.pointee }
    }
    
    public var ip_hexInt: UInt? {
        return self.to(type: UInt.self)
    }
    
    public var ip_intValue: Int {
        return self.to(type: Int.self)
    }
    
    public var ip_uint8Value: UInt8 {
        return self.to(type: UInt8.self)
    }
    
    public var ip_utf8String: String? {
        return String(data: self as Data, encoding: .utf8)
    }
    
    public var ip_asciiString: String? {
        return String(data: self as Data, encoding: .ascii)
    }
}


extension Data {
    public func ip_chunks(ofLength length: Int, includeRemainder: Bool = true) -> [NSData] {
        let range = 0..<length
        let mutable = NSMutableData(data: self as Data)
        var chunks: [NSData] = []
        while mutable.length >= length {
            guard let next = mutable[range] else { break }
            chunks.append(next)
            mutable.ip_trimRange(range)
        }
        
        if includeRemainder && mutable.length > 0 {
            let trailingData = NSData(data: mutable as Data)
            chunks.append(trailingData)
        }
        
        return chunks
    }
}

extension Data {
    public func ip_segmentGenerator(start: Int = 0, chunkLength: Int) -> AnyIterator<Data> {
        let segmentToWrite = suffix(from: start)
        var mutable = segmentToWrite.base
        let range = 0..<chunkLength
        return AnyIterator {
            let nextData: Data?
            if mutable.count >= chunkLength {
                nextData = mutable[range].base
                mutable.removeSubrange(range)
            } else if mutable.count > 0 {
                nextData = mutable
                mutable.count = 0
            } else {
                nextData = nil
            }
            return nextData
        }
    }
}

extension Data {
    public init(byte: UInt8) {
        self.init(bytes: [byte])
    }
}

extension Data {    
    public mutating func appendUTF8String(_ string: String) {
        guard let data = string.ip_utf8Data else { return }
        append(data)
    }
}


extension Data {
    /// Safer version `subdata`. Will return nil if the range is outside the bounds of the data.
    public subscript(range: Range<Int>) -> Data? {
        guard range.lowerBound >= 0 else { return nil }
        guard count >= range.upperBound else { return nil }
        let rangeLength = range.upperBound - range.lowerBound
        guard rangeLength > 0 else { return nil }
        return subdata(in: range)
    }
}
