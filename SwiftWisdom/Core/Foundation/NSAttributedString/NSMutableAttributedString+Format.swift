//
//  NSAttributedString+Format.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 1/16/16.
//  Copyright © 2016 Intrepid-Pursuits. All rights reserved.
//

import Foundation

public extension NSMutableAttributedString {

    /**
     Create a mutable attributed string with the attributes applied to all arguments.
     
     - parameter string:     formatted string where `%@` represents an argument.
     - parameter attributes: attributes dictionary to use on arguments
     - parameter args:       comma separated list of arguments
     
     - returns: NSMutableAttributedString with the attributes applied to argument strings.
     */
    convenience init(formatString: String, attributes: [String : AnyObject], arguments: String...) {
        let arguments = arguments.map { NSAttributedString(string: $0, attributes: attributes) }
        self.init(string: formatString)
        ip_format(withArguments: arguments)
    }

    /**
     Create a mutable attributed string with the attributes applied to all arguments.

     - parameter string:     formatted string where `%@` represents an argument
     - parameter attributes: attributes dictionary to use on arguments
     - parameter args:       array of attributed strings

     - returns: NSMutableAttributedString with the attributes applied to argument strings.
     */
    convenience init(formatString string: String, attributes: [String : AnyObject]?, arguments: [NSAttributedString]) {
        let mutable = NSMutableAttributedString(string: string, attributes: attributes)
        mutable.ip_format(withArguments: arguments)
        self.init(attributedString: mutable)
    }

    /**
     Create a mutable attributed string with the given list of NSAttributedString
     
     - parameter string: formatted string where `%@` represents an argument.
     - parameter args:   comma separated list of arguments (NSAttributedString)
     
     - returns: NSMutableAttributedString with arguments inserted according to format.
     */
    convenience init(formatString: String, arguments: NSAttributedString...) {
        self.init(string: formatString)
        ip_format(withArguments: arguments)
    }

    /**
     Create a mutable attributed string with the given collection of NSAttributedString
     
     - parameter string: formatted string where `%@` represents an argument.
     - parameter args:   comma separated list of arguments (NSAttributedString)
     
     - returns: NSMutableAttributedString with arguments inserted according to format.
     */

    convenience init(formatString: String, arguments: [NSAttributedString]) {
        self.init(string: formatString)
        ip_format(withArguments: arguments)
    }

    // See ip_format(arguments: [NSAttributedString])
    func ip_format(withArguments arguments: NSAttributedString...) {
        ip_format(withArguments: arguments)
    }

    /**
     Assumes that the received is a attributed string with format placeholders "%@". Inserts the
     NSAttributedString in args into each of the placeholders.

     - parameter arguments: comma separated list of arguments (NSAttributedString)
     */
    func ip_format(withArguments arguments: [NSAttributedString]) {
        var rangeLimit = string.ip_fullrange
        let str = string as NSString
        var insertRange = str.range(of: "%@", options: .backwards, range: rangeLimit)
        arguments.reversed().forEach { arg in
            guard insertRange.location != NSNotFound else { return }
            replaceCharacters(in: insertRange, with: arg)
            rangeLimit = NSRange(location: 0, length: insertRange.location)
            insertRange = str.range(of: "%@", options: .backwards, range: rangeLimit)
        }
    }
}
