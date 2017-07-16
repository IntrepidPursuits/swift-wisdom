//
//  UILabel+Typography.swift
//  SwiftWisdom
//
//  Created by Patrick Butkiewicz on 4/15/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    /**
     Sets the text of the UILabel instance to an attributed string with tracking applied
     - Parameter value: The value in points that each character is kerned to
     */
    public func ip_setCharacterSpacing(_ value: CGFloat) {
        addAttribute(NSKernAttributeName, value: value)
    }

    /**
     Sets the text of the UILabel instance to an attributed string with the specified line spacing
     - Parameter value: The space, in points, between each line.
     */
    public func ip_setLineSpacing(_ value: CGFloat) {
        let paragraphSpacing = NSMutableParagraphStyle()
        paragraphSpacing.lineSpacing = value
        paragraphSpacing.alignment = textAlignment
        addAttribute(NSParagraphStyleAttributeName, value: paragraphSpacing)
    }

    // MARK: Private

    private func addAttribute(_ attr: String, value: Any) {
        let attrText = mutableAttributedText()
        attrText.addAttributes([attr : value], range: NSRange(location: 0, length: attrText.length))
        text = nil
        attributedText = attrText
    }

    private func baseAttributes() -> [String : AnyObject] {
        return [NSFontAttributeName : font, NSForegroundColorAttributeName : textColor]
    }

    private func mutableAttributedText() -> NSMutableAttributedString {
        let bareText = text ?? ""

        if let attributedText = attributedText {
            return NSMutableAttributedString(attributedString: attributedText)
        } else {
            return NSMutableAttributedString(string: bareText, attributes: baseAttributes())
        }
    }

}
