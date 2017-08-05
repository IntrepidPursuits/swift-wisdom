//
//  String+Attributed.swift
//  SwiftWisdom
//
//  Created by Alexander Persian on 12/30/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

public extension String {
    func ip_attributedStringWithSpacing(_ spacingValue: CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSKernAttributeName, value: spacingValue, range: NSRange(location: 0, length: self.characters.count))
        return attributedString
    }
}
