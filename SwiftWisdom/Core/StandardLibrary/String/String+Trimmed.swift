//
//  String+Trimmed.swift
//  SwiftWisdom
//
//  Created by Maya Saxena on 6/13/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import Foundation

extension String {
    func ip_trimmed(toLength length: Int) -> String {
        return String(prefix(length))
    }
}
