//
//  Double+Extensions.swift
//  SwiftWisdom
//
//  Created by Stephen Wong on 5/1/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension Double {
    public func ip_roundToDecimalPlaces(decimalPlaces: Int) -> Double {
        let decimalShiftBase10 = pow(10.0, Double(decimalPlaces))
        let roundedNumber = round(self * decimalShiftBase10)
        let shiftDecimalPlaces = roundedNumber / decimalShiftBase10
        return shiftDecimalPlaces
    }
}
