//
//  Int+Extensions.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension IntegerType {
    public var ip_isEven: Bool {
        return (self % 2) == 0
    }
    
    public var ip_isOdd: Bool {
        return !ip_isEven
    }
}

extension IntegerType {
    public func ip_times(@noescape closure: Block) {
        precondition(self >= 0)
        (0..<self).forEach { _ in closure() }
    }
}

extension IntegerType {
    public func ip_toMagnitudeString(decimalPlaces decimals: Double = 1) -> String {
        
        print(self)
        
        guard self > 999 else { return "\(self)" }
        
        let likes = Double(self.toIntMax())
        
        let units = ["K", "M", "B", "T"]
        var magnitude: Int = Int(log10(likes) / 3.0) // the order of magnitude of our like count in thousands
        
        // this formula rounds the likes to the nearest 1000s magnitude with X decimal points
        // E.G. - 75633 becomes 75.63
        // if X is 2
        // pow(1000.0, Double(magnitude)) = 1000^1 = 1000
        // 10 ^ 2 * likes / 1000 = 7563.3
        // round(7563.3) = 7563
        // 7563 / 10 ^ 2 = 75.63
        var roundedLikes = round(pow(10.0, decimals) * likes / pow(1000.0, Double(magnitude))) / pow(10.0, decimals)
        
        // if rounding brings our display number over 1000, divide by 1000 and then bump the magnitude
        if roundedLikes >= 1000 {
            roundedLikes /= 1000.0
            magnitude += 1
        }
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = Int(decimals)
        
        guard let likesFormatted = formatter.stringFromNumber(roundedLikes) else { return "\(roundedLikes)\(units[magnitude-1])" }
        
        return "\(likesFormatted)\(units[magnitude-1])";
    }
}
