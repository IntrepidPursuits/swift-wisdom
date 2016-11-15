//
//  NSData+Extensions.swift
//  bmap
//
//  Created by Logan Wright on 11/25/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

extension NSData {
    // From here: http://stackoverflow.com/a/30415543/2611971
    public var ip_hexString: String? {
        guard length > 0 else { return nil }

        let  hexChars = Array("0123456789abcdef".utf8) as [UInt8]
        let bufer = UnsafeBufferPointer<UInt8>(start: bytes.assumingMemoryBound(to: UInt8.self), count: length)
        var output = [UInt8](repeating: 0, count: (length * 2) + 1)
        var ix: Int = 0
        bufer.forEach {
            let hi  = Int(($0 & 0xf0) >> 4)
            let low = Int($0 & 0x0f)
            output[ix] = hexChars[hi]
            ix += 1
            output[ix] = hexChars[low]
            ix += 1
        }
        let result = String(cString: UnsafePointer(output))
        return result
    }
    
    public var ip_hexInt: UInt? {
        guard let hexString = ip_hexString else { return nil }
        return strtoul(hexString, nil, 16)
    }
    
    public var ip_intValue: Int? {
        var val: Int = 0
        getBytes(&val, length: MemoryLayout<Int>.size)
        return val
    }
    
    public var ip_uint8Value: UInt8? {
        var val: UInt8 = 0
        getBytes(&val, length: MemoryLayout<UInt8>.size)
        return val
    }
    
    public var ip_utf8String: String? {
        return String(data: self as Data, encoding: .utf8)
    }
    
    public var ip_asciiString: String? {
        return String(data: self as Data, encoding: .ascii)
    }
}

extension NSData {

    public subscript(idx: Int) -> NSData? {
        guard length >= idx + 1 else { return nil }
        return subdata(with: NSMakeRange(idx, 1)) as NSData
    }

    public subscript(range: CountableRange<Int>) -> NSData? {
        return ip_subdataFrom(range.startIndex, length: range.count)
    }
    
    public subscript(range: CountableClosedRange<Int>) -> NSData? {
        return ip_subdataFrom(range.lowerBound, length: range.count)
    }

    /*
    Inclusive, ie: 1 will include index 1
    */
    public func ip_suffixFrom(_ startIdx: Int) -> NSData? {
        return self.ip_subdataFrom(startIdx, length: length - startIdx)
    }
    
    /*
    Inclusive, ie: 1 will include index 1
    */
    public func ip_prefixThrough(_ endIdx: Int) -> NSData? {
        guard endIdx >= 0 else { return nil }
        return self.ip_subdataFrom(0, length: endIdx + 1)
    }

    public func ip_subdataFrom(_ idx: Int, length: Int) -> NSData? {
        let end = self.length - 1
        guard idx <= end && idx + length <= self.length else { return nil }
        let data = subdata(with: NSMakeRange(idx, length)) as NSData
        return data.length > 0 ? data : nil // Would expect an empty Data object to just return nil.
    }
}

extension NSMutableData {
    public func ip_trimRange(_ range: Range<Int>) {
        ip_trimRange(CountableRange<Int>(range))
    }

    public func ip_trimRange(_ range: CountableRange<Int>) {
        ip_trimRange(start: range.lowerBound, end: range.upperBound - 1) // CountableRange = (non inclusive)
    }
    
    public func ip_trimRange(_ range: CountableClosedRange<Int>) {
        ip_trimRange(start: range.lowerBound, end: range.upperBound)
    }

    private func ip_trimRange(start: Int, end: Int) {
        let prefix = ip_prefixThrough(start - 1)  ?? NSData() // Don't want to include the bottom of the range being trimmed.
        let suffix = ip_suffixFrom(end + 1) ?? NSData() // Don't want to include the top of the range being trimmed.

        length = 0
        append(prefix as Data)
        append(suffix as Data)
    }
}



extension NSData {
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

extension NSData {
    public func ip_segmentIterator(start: Int = 0, chunkLength: Int) -> AnyIterator<NSData> {
        guard let segmentToWrite = ip_suffixFrom(start) else { return AnyIterator { return nil } }
        let mutable = NSMutableData(data: segmentToWrite as Data)
        let range = 0..<chunkLength
        return AnyIterator {
            let nextData: NSData?
            if mutable.length >= chunkLength {
                nextData = mutable[range]
                mutable.ip_trimRange(range)
            } else if mutable.length > 0 {
                nextData = NSData(data: mutable as Data)
                mutable.length = 0
            } else {
                nextData = nil
            }
            return nextData
        }
    }
}

extension NSData {
    public convenience init(byte: UInt8) {
        var _byte = byte
        self.init(bytes: &_byte, length: MemoryLayout<UInt8>.size)
    }
}

extension NSMutableData {
    public func ip_appendByte(_ byte: UInt8) {
        var byte = byte
        append(&byte, length: MemoryLayout<UInt8>.size)
    }
    
    public func appendUTF8String(_ string: String) {
        guard let data = string.ip_utf8Data else { return }
        append(data as Data)
    }
}
