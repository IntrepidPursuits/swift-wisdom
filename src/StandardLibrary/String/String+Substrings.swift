//
//  String+Substrings.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/27/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import Foundation

extension String {
    subscript(range: Range<Int>) -> String {
        let chars = Array(characters)
        let substringCharacters = chars[range]
        return String(substringCharacters)
    }
    
    mutating func dropFirst() {
        self = self[1..<characters.count]
    }
}
