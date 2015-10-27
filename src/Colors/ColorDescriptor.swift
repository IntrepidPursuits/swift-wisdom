//
//  ColorDescriptor.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import UIKit

enum ColorDescriptor {
    case PatternImage(imageName: String)
    case RGB(r: Int, g: Int, b: Int, a: Int)
    case Hex(hex: String)
}

extension ColorDescriptor : StringLiteralConvertible, RawRepresentable, Equatable {
    typealias RawValue = StringLiteralType
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    typealias UnicodeScalarLiteralType = StringLiteralType
    
    var color: UIColor {
        switch self {
        case let .PatternImage(imageName: imageName):
            let image = UIImage(named: imageName)!
            return UIColor(patternImage: image)
        case let .RGB(r: ri, g: gi, b: bi, a: ai):
            let r = CGFloat(ri)
            let g = CGFloat(gi)
            let b = CGFloat(bi)
            let a = CGFloat(ai)
            return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a / 255)
        case let .Hex(hex: hex):
            return UIColor(hex: hex)
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case let .PatternImage(imageName: imageName):
            return imageName
        case let .RGB(r: r, g: g, b: b, a: a):
            return "\(r),\(g),\(b),\(a)"
        case let .Hex(hex: hex):
            return hex
        }
    }
    
    // MARK: Initializers
    
    init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(value)
    }
    
    init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(value)
    }
    
    init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    init?(rawValue: RawValue) {
        self.init(rawValue)
    }
    
    init(_ string: String) {
        let rgbComponents = string.componentsSeparatedByString(",")
            .flatMap { Int($0) }
        if rgbComponents.count == 4 {
            self = .RGB(r: rgbComponents[0], g: rgbComponents[1], b: rgbComponents[2], a: rgbComponents[3])
        } else if string.hasPrefix("#") {
            self = .Hex(hex: string)
        } else if let _ = UIImage(named: string) {
            self = .PatternImage(imageName: string)
        } else {
            fatalError(
                "Unrecognized color literal! Use format `r,g,b,a` on 255 scale, a valid UIImage name, or a 6 character hex string w/ `#`")
        }
    }
}

func ==(lhs: ColorDescriptor, rhs: ColorDescriptor) -> Bool {
    return lhs.rawValue == rhs.rawValue
}
