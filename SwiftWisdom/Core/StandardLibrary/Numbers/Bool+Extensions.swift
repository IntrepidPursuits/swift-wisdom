//
//  Bool+Extensions.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension Bool {
    init(ip_string: String) {
        let cleaned = ip_string.lowercaseString
        let truePrefixes = [
            "t",
            "y",
            "1",
        ]
        
        self = truePrefixes.contains { cleaned.hasPrefix($0) }
    }
}
