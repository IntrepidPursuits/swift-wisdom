//
//  String+Data.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 3/31/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation


public extension String {
    public var ip_hexInt: UInt {
        return strtoul(self, nil, 16)
    }
}
