//
//  NSData+Extensions.swift
//  bmap
//
//  Created by Logan Wright on 11/25/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

public extension NSData {
    // From here: http://stackoverflow.com/a/30415543/2611971
    public var ip_hexString: String? {
        guard length > 0 else { return nil }
        
        let  hexChars = Array("0123456789abcdef".utf8) as [UInt8]
        let bufer = UnsafeBufferPointer<UInt8>(start: UnsafePointer(bytes), count: length)
        var output = [UInt8](count: (length * 2) + 1, repeatedValue: 0)
        var ix: Int = 0
        bufer.forEach {
            let hi  = Int(($0 & 0xf0) >> 4)
            let low = Int($0 & 0x0f)
            output[ix] = hexChars[hi]
            ix += 1
            output[ix] = hexChars[low]
            ix += 1
        }
        let result = String.fromCString(UnsafePointer(output))
        return result
    }
    
    public var ip_hexInt: UInt? {
        guard let hexString = ip_hexString else { return nil }
        return strtoul(hexString, nil, 16)
    }
    
    public var ip_intValue: Int? {
        var val: Int = 0
        getBytes(&val, length: sizeof(Int))
        return val
    }
    
    public var ip_uint8Value: UInt8? {
        var val: UInt8 = 0
        getBytes(&val, length: sizeof(UInt8))
        return val
    }
    
    public var ip_utf8String: String? {
        return String(data: self, encoding: NSUTF8StringEncoding)
    }
    
    public var ip_asciiString: String? {
        return String(data: self, encoding: NSASCIIStringEncoding)
    }
}

public extension NSData {
    public subscript(idx: Int) -> NSData? {
        guard length >= idx + 1 else { return nil }
        return subdataWithRange(NSMakeRange(idx, 1))
    }
}

public extension NSData {
    /*
    Inclusive, ie: 1 will include index 1
    */
    public func ip_suffixFrom(startIdx: Int) -> NSData? {
        let end = length - 1
        guard startIdx <= end else { return nil }
        return self[startIdx...end]
    }
    
    /*
    Inclusive, ie: 1 will include index 1
    */
    public func ip_prefixThrough(endIdx: Int) -> NSData? {
        guard endIdx >= 0 else { return nil }
        return self[0...endIdx]
    }
}

public extension NSMutableData {
    public func ip_trimRange(range: Range<Int>) {
        let frontRange = range.startIndex - 1
        let endRange = range.endIndex
        
        let prefix = ip_prefixThrough(frontRange) ?? NSData()
        let suffix = ip_suffixFrom(endRange) ?? NSData()
        
        length = 0
        appendData(prefix)
        appendData(suffix)
    }
}



extension NSData {
    public func ip_chunks(ofLength length: Int, includeRemainder: Bool = true) -> [NSData] {
        let range = 0..<length
        let mutable = NSMutableData(data: self)
        var chunks: [NSData] = []
        while mutable.length >= length {
            guard let next = mutable[range] else { break }
            chunks.append(next)
            mutable.ip_trimRange(range)
        }
        
        if includeRemainder && mutable.length > 0 {
            let trailingData = NSData(data: mutable)
            chunks.append(trailingData)
        }
        
        return chunks
    }
}

extension NSData {
    public func ip_segmentGenerator(start start: Int = 0, chunkLength: Int) -> AnyGenerator<NSData> {
        guard let segmentToWrite = ip_suffixFrom(start) else { return AnyGenerator { return nil } }
        let mutable = NSMutableData(data: segmentToWrite)
        let range = 0..<chunkLength
        return AnyGenerator {
            let nextData: NSData?
            if mutable.length >= chunkLength {
                nextData = mutable[range]
                mutable.ip_trimRange(range)
            } else if mutable.length > 0 {
                nextData = NSData(data: mutable)
                mutable.length = 0
            } else {
                nextData = nil
            }
            return nextData
        }
    }
}

extension NSData {
    public func ip_subdataFrom(idx: Int, length: Int) -> NSData? {
        return self[idx..<(idx + length)]
    }
}

extension NSData {
    public convenience init(byte: UInt8) {
        var _byte = byte
        self.init(bytes: &_byte, length: sizeof(UInt8))
    }
}

extension NSMutableData {
    public func ip_appendByte(byte: UInt8) {
        var byte = byte
        appendBytes(&byte, length: sizeof(UInt8))
    }
    
    public func appendUTF8String(string: String) {
        guard let data = string.ip_utf8Data else { return }
        appendData(data)
    }
}


extension NSData {
    public subscript(range: Range<Int>) -> NSData? {
        guard range.startIndex >= 0 else { return nil }
        guard length >= range.endIndex else { return nil }
        let rangeLength = range.endIndex - range.startIndex
        guard rangeLength > 0 else { return nil }
        let nsrange = NSMakeRange(range.startIndex, rangeLength)
        return subdataWithRange(nsrange)
    }
}
