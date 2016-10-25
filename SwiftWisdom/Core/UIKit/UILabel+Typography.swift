//
//  UILabel+Typography.swift
//  SwiftWisdom
//
//  Created by Patrick Butkiewicz on 4/15/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation
import UIKit

extension Intrepid where Base: UILabel {
    /**
     Sets the text of the UILabel instance to an attributed string with tracking applied
     - Parameter value: The value in points that each character is kerned to
     */
    public func setCharacterSpacing(_ value: CGFloat) {
        addAttribute(NSKernAttributeName, value: value)
    }
    
    /**
     Sets the text of the UILabel instance to an attributed string with the specified line spacing
     - Parameter value: The space, in points, between each line.
     */
    public func setLineSpacing(_ value: CGFloat) {
        let paragraphSpacing = NSMutableParagraphStyle()
        paragraphSpacing.lineSpacing = value
        paragraphSpacing.alignment = base.textAlignment
        addAttribute(NSParagraphStyleAttributeName, value: paragraphSpacing)
    }
    
    // MARK: Private
    
    private func addAttribute(_ attr: String, value: Any) {
        let attrText = mutableAttributedText()
        attrText.addAttributes([attr : value], range: NSMakeRange(0, attrText.length))
        base.text = nil
        base.attributedText = attrText
    }
    
    private func baseAttributes() -> [String : AnyObject] {
        return [NSFontAttributeName : base.font, NSForegroundColorAttributeName : base.textColor]
    }
    
    private func mutableAttributedText() -> NSMutableAttributedString {
        let bareText = base.text ?? ""
        
        if let attributedText = base.attributedText {
            return NSMutableAttributedString(attributedString: attributedText)
        } else {
            return NSMutableAttributedString(string: bareText, attributes: baseAttributes())
        }
    }
    
}
