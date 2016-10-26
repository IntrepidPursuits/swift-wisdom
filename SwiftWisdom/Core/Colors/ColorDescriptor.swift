//
//  ColorDescriptor.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import UIKit

public protocol ColorPalette {
    var rawValue: ColorDescriptor { get }
}

extension ColorPalette {
    public var color: UIColor {
        return rawValue.color
    }
}

public enum ColorDescriptor {
    case patternImage(imageName: String)
    case rgb255(r: Int, g: Int, b: Int, a: Int)
    case rgbFloat(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)
    case hex(hex: String)
}

extension ColorDescriptor : ExpressibleByStringLiteral, RawRepresentable, Equatable {
    public typealias RawValue = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias UnicodeScalarLiteralType = StringLiteralType
    
    public var color: UIColor {
        switch self {
        case let .patternImage(imageName: imageName):
            let image = UIImage(named: imageName)!
            return UIColor(patternImage: image)
        case let .rgb255(r: ri, g: gi, b: bi, a: ai):
            let r = CGFloat(ri)
            let g = CGFloat(gi)
            let b = CGFloat(bi)
            let a = CGFloat(ai)
            return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a / 255)
        case let .rgbFloat(r: r, g: g, b: b, a: a):
            return UIColor(red: r, green: g, blue: b, alpha: a)
        case let .hex(hex: hex):
            return UIColor(ip_hex: hex)
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case let .patternImage(imageName: imageName):
            return imageName
        case let .rgb255(r: r, g: g, b: b, a: a):
            return "\(r),\(g),\(b),\(a)"
        case let .rgbFloat(r: r, g: g, b: b, a: a):
            return "\(r),\(g),\(b),\(a)"
        case let .hex(hex: hex):
            return hex
        }
    }
    
    // MARK: Initializers
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(value)
    }

    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init?(rawValue: RawValue) {
        self.init(rawValue)
    }
    
    public init(_ string: String) {
        let rgbComponents = string.components(separatedBy: ",")
        if rgbComponents.count == 4 {
            // If any portion of the string has a `.`, we are in 0-1.0 scale
            if string.contains(".") {
                let floats = rgbComponents
                    .flatMap { Double($0) }
                    .map { CGFloat($0) }
                self = .rgbFloat(r: floats[0], g: floats[1], b: floats[2], a: floats[3])
            } else {
                let ints = rgbComponents.flatMap { Int($0) }
                self = .rgb255(r: ints[0], g: ints[1], b: ints[2], a: ints[3])
            }
        } else if string.hasPrefix("#") {
            self = .hex(hex: string)
        } else if let _ = UIImage(named: string) {
            self = .patternImage(imageName: string)
        } else {
            fatalError(
                "Unrecognized color literal! Use format `r,g,b,a` on 255 or 0-1.0 scale, a valid UIImage name, or a 6 character hex string w/ `#` prefix")
        }
    }
}

// MARK: Operator Overloads

extension ColorDescriptor {
    public static func == (lhs: ColorDescriptor, rhs: ColorDescriptor) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
