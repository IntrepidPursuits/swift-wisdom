//
//  CountableClosedRange+Extensions.swift
//  SwiftWisdom
//
//  Created by Andrew Dolce on 11/21/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

public extension CountableClosedRange where Bound: SignedInteger {
    public func ip_random() -> Bound {
        return ip_random(withUniformRNGFunction: { upperBound in
            return Int(arc4random_uniform(UInt32(upperBound)))
        })
    }

    internal typealias UniformRandomNumberGeneratorFunction = (Int) -> Int

    internal func ip_random(withUniformRNGFunction rngFunction: UniformRandomNumberGeneratorFunction) -> Bound {
        let diff: Int = lowerBound.distance(to: upperBound)
        let randomOffset = rngFunction(diff + 1)
        return lowerBound.advanced(by: randomOffset)
    }
}
