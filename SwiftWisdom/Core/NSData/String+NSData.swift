//
//  String+NSData.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

//
//  String+Extensions.swift
//  bmap
//
//  Created by Logan Wright on 11/25/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

extension String {
    public var hexInt: UInt {
        return strtoul(self, nil, 16)
    }
}

extension String {
    
    /**
     Convert a hex string to NSData.  Mostly for testing
     
     - returns: data from the hex string
     */
    public func ip_dataFromHexadecimalString() -> NSData? {
        let clean = lowercased().replacingOccurrences(of: " ", with: "")
        let allowed = CharacterSet.alphanumerics
        let trimmed = clean.trimmingCharacters(in: allowed.inverted)
        guard !trimmed.isEmpty && trimmed.characters.count.ip_isEven else { return nil }
        
        // everything ok, so now let's build NSData
        
        let data = NSMutableData(capacity: trimmed.characters.count / 2)

        for i in stride(from: 0, through: trimmed.characters.count - 2, by: 2) {
            let byteString = trimmed[i...i + 1]
            var byte = byteString.hexInt // was `byteString.withCString { strtoul($0, nil, 16) }`, test
            data?.append(&byte, length: MemoryLayout<UInt8>.size)
        }
        
        return data
    }
}

extension String {
    public var ip_utf8Data: NSData? {
        return data(using: .utf8) as NSData?
    }
}

extension String {
    public var ip_intValue: Int? {
        return Int(self)
    }
    
    public func ip_contains(_ find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    public var ip_length: Int {
        return self.characters.count
    }
}
