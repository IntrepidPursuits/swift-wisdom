//
//  Data+Extensions.swift
//  bmap
//
//  Created by Paul Rolfe on 11/10/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

// MARK: Conversion

extension Data {
    // From here: http://stackoverflow.com/questions/39075043/how-to-convert-data-to-hex-string-in-swift
    public var ip_hexString: String? {
        guard self.count > 0 else { return nil }
        return map { String(format: "%02hhx", $0) }.joined()
    }

    // MARK: Convenience

    public func to<T: DataConvertible>(type: T.Type) -> T? {
        guard self.count > 0 else { return nil }
        return T(ip_data: self)
    }

    public var ip_hexInt: UInt? {
        guard let hexString = ip_hexString else { return nil }
        return strtoul(hexString, nil, 16)
    }

    public var ip_intValue: Int? {
        return self.to(type: Int.self)
    }

    public var ip_int8Value: Int8? {
        return self.to(type: Int8.self)
    }

    public var ip_uint8Value: UInt8? {
        return self.to(type: UInt8.self)
    }

    public var ip_uint16Value: UInt16? {
        return self.to(type: UInt16.self)
    }

    public var ip_uint32Value: UInt32? {
        return self.to(type: UInt32.self)
    }

    public var ip_uint64Value: UInt64? {
        return self.to(type: UInt64.self)
    }

    public var ip_int16Value: Int16? {
        return self.to(type: Int16.self)
    }

    public var ip_int32Value: Int32? {
        return self.to(type: Int32.self)
    }

    public var ip_int64Value: Int64? {
        return self.to(type: Int64.self)
    }

    public var ip_utf8String: String? {
        guard self.count > 0 else { return nil }
        return String(data: self as Data, encoding: .utf8)
    }

    public var ip_asciiString: String? {
        guard self.count > 0 else { return nil }
        return String(data: self as Data, encoding: .ascii)
    }
}

extension Data {
    public mutating func ip_appendUTF8String(_ string: String) {
        guard let data = string.ip_utf8Data else { return }
        append(data)
    }
}

// MARK: Custom Init

extension Data {
    public init(byte: UInt8) {
        self.init(bytes: [byte])
    }
}

// MARK: Subscript

extension Data {
    /// Safer version of `subdata`. Will return nil if the range is outside the bounds of the data.
    public subscript(ip_safely idx: Int) -> Data? {
        return self[ip_safely: idx...idx]
    }

    /// Safer version of `subdata`. Will return nil if the range is outside the bounds of the data.
    public subscript(ip_safely range: CountableRange<Int>) -> Data? {
        return self[ip_safely: Range<Int>(range)]
    }

    /// Safer version of `subdata`. Will return nil if the range is outside the bounds of the data.
    public subscript(ip_safely range: CountableClosedRange<Int>) -> Data? {
        return self[ip_safely: Range<Int>(range)]
    }

    /// Safer version of `subdata`. Will return nil if the range is outside the bounds of the data.
    public subscript(ip_safely range: Range<Int>) -> Data? {
        guard range.lowerBound >= 0, count >= range.upperBound else { return nil }
        let rangeLength = range.upperBound - range.lowerBound
        guard rangeLength > 0 else { return nil }
        return subdata(in: range)
    }
}

extension Data {
    public func ip_suffix(from idx: Int) -> Data? {
        guard count > idx else { return nil }
        return self[ip_safely: idx..<endIndex]
    }
}

extension Data {
    public func ip_chunks(ofLength length: Int, includeRemainder: Bool = true) -> [Data] {
        let range = 0..<length
        var mutable = self
        var chunks: [Data] = []
        while mutable.count >= length {
            guard let next = mutable[ip_safely: range] else { break }
            chunks.append(next)
            mutable.removeSubrange(range)
        }

        if includeRemainder && mutable.count > 0 {
            let trailingData = mutable
            chunks.append(trailingData)
        }

        return chunks
    }
}

extension Data {
    public func ip_segmentIterator(start: Int = 0, chunkLength: Int) -> AnyIterator<Data> {
        let segmentToWrite = ip_suffix(from: start)
        var mutable = segmentToWrite
        let range = 0..<chunkLength
        return AnyIterator {
            let nextData: Data?
            if let remaining = mutable, remaining.count >= chunkLength {
                nextData = mutable?[ip_safely:range]
                mutable?.removeSubrange(range)
            } else if let remaining = mutable, remaining.count > 0 {
                nextData = mutable
                mutable?.count = 0
            } else {
                nextData = nil
            }
            return nextData
        }
    }
}
