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
        let clean = lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
        let allowed = NSCharacterSet.alphanumericCharacterSet()
        let trimmed = clean.stringByTrimmingCharactersInSet(allowed.invertedSet)
        guard !trimmed.isEmpty && trimmed.characters.count.ip_isEven else { return nil }
        
        // everything ok, so now let's build NSData
        
        let data = NSMutableData(capacity: trimmed.characters.count / 2)
        
        for i in 0.stride(through: trimmed.characters.count - 2, by: 2) {
            let byteString = trimmed[i...i + 1]
            var byte = byteString.withCString {
                strtoul($0, nil, 16)
            }
            data?.appendBytes(&byte, length: sizeof(UInt8))
        }
        
        return data
    }
}

extension String {
    public var ip_utf8Data: NSData? {
        return dataUsingEncoding(NSUTF8StringEncoding)
    }
}

extension String {
    public var ip_intValue: Int? {
        return Int(self)
    }
    
    public func ip_contains(find: String) -> Bool {
        return self.rangeOfString(find) != nil
    }
    
    public var ip_length: Int {
        return self.characters.count
    }
}

extension String : CustomStringConvertible {
    public var description: String {
        return self
    }
}
