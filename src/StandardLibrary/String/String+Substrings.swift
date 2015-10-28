//
//  String+Substrings.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/27/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import Foundation

public extension String {
    public subscript(range: Range<Int>) -> String {
        let chars = Array(characters)
        let substringCharacters = chars[range]
        return String(substringCharacters)
    }
    
    public mutating func dropFirst() {
        guard !isEmpty else { return }
        self = self[1..<characters.count]
    }
}
