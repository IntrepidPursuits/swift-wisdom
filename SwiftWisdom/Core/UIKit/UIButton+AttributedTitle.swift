//
//  UIButton+AttributedTitle.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 3/14/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

public extension UIButton {

    /**
     This will use existing attributes on the attributed text, plus the spacing passed in and apply 
     them to the string passed in.

     - parameter text:    New `String` to use for title label's attributed text.
     - parameter spacing: Value to use for kern
     - parameter state:   `UIControlState`
     */
    func ip_editAttributedTitle(_ text: String?, useSpacing spacing: CGFloat = 0.0, forState state: UIControlState) {
        let rangePointer: NSRangePointer? = nil
        let spacedText = text?.ip_attributedStringWithSpacing(spacing)
        if let existingAttributes = titleLabel?.attributedText?.attributes(at: 0, effectiveRange: rangePointer),
            let spacedText = spacedText,
            let color = titleColor(for: state) {
            let range = NSRange(location: 0, length: spacedText.length)
            spacedText.addAttributes(existingAttributes, range: range)
            spacedText.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
        }
        setAttributedTitle(spacedText, for: state)
    }
}
