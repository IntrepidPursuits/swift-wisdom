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
    public func ip_toMagnitudeString(decimalPlaces decimalPlaces: Int = 1) -> String {
        
        guard self > 999 else { return "\(self)" }
        
        let units = ["K", "M", "B", "T", "Q"]
        
        let value = Double(self.toIntMax())
        
        var magnitude: Int = Int(log10(value) / 3.0) // the order of magnitude of our value in thousands
        
        // divide value by 1000^magnitude to get hundreds value, then round to desired decimal places
        var roundedHundredsValue = (value / pow(1000.0, Double(magnitude))).ip_roundToDecimalPlaces(decimalPlaces)
        
        // if rounding brings our display value over 1000, divide by 1000 and then bump the magnitude
        if roundedHundredsValue >= 1000 {
            roundedHundredsValue /= 1000.0
            magnitude += 1
        }
        
        // if our number exceeds our current magnitude system return the scientific notation
        let magnitudeSuffix = units[ip_safe: magnitude - 1] ?? "E\(magnitude * 3)"
        
        let formatter = NSNumberFormatter.decimalFormatter
        guard let valueFormatted = formatter.stringFromNumber(roundedHundredsValue) else {
            return "\(roundedHundredsValue)\(magnitudeSuffix)"
        }
        
        return "\(valueFormatted)\(magnitudeSuffix)"
    }
}

extension NSNumberFormatter {
    private static var decimalFormatter: NSNumberFormatter {
        let decimalFormatter = NSNumberFormatter()
        decimalFormatter.numberStyle = .DecimalStyle
        decimalFormatter.minimumFractionDigits = 0
        return decimalFormatter
    }
}

public extension Int {
    public var minutesAndSecondsString: String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
