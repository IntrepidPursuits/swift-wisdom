//
//  String+Empty.swift
//  SwiftWisdom
//
//  Created by Benjamin Wu on 3/4/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension String {
    public func ip_isEmptyOrWhitespace() -> Bool {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
}
