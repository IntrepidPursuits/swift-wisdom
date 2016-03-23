//
//  String+EmailValidation.swift
//  SwiftWisdom
//
//  Created by Benjamin Wu on 3/4/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension String {
    /**
     At a minimum emails need an @ and . with at least one character preceeding between and after.  The philosophy here
     is that email validation should primarily be handled by a confirmation email and that the user generally knows
     what they are inputting.  We are trying to prevent false-negatives.

     - returns: True if the string contains an @ followed by a . with characters before between and after.
     */
    public func ip_isValidEmail() -> Bool {
        return rangeOfString(".@.+\\.", options: .RegularExpressionSearch) != nil
    }
}
