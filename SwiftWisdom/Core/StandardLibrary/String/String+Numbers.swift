//
//  String+Numbers.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 11/10/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension String {
    public var ip_hexInt: UInt {
        return strtoul(self, nil, 16)
    }
    
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
