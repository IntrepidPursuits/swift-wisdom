//
//  UIColor+Hex.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/27/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import UIKit

public extension UIColor {
    public convenience init(ip_hex hex: String) {
        var cleanHex: String = hex.uppercased()
        if hex.hasPrefix("#") {
            cleanHex.ip_dropFirst()
        }
        if cleanHex.count != 6 {
            cleanHex = "FFFFFF"
        }

        let rString = cleanHex[0...1]
        let gString = cleanHex[2...3]
        let bString = cleanHex[4...5]

        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)

        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: CGFloat(1)
        )
    }
}
