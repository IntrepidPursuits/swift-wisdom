//
//  Collection+Random.swift
//  SwiftWisdom
//
//  Created by Andrew Dolce on 2/17/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import Foundation

public extension Collection {
    public func ip_random() -> Self.Iterator.Element {
        return ip_random(withUniformRNGFunction: arc4random_uniform)
    }

    func ip_random(withUniformRNGFunction rngFunction: (UInt32) -> UInt32) -> Self.Iterator.Element {
        let upperBound = UInt32(count.toIntMax())
        let randomDistance = IndexDistance(IntMax(rngFunction(upperBound)))
        let randomIndex = index(startIndex, offsetBy: randomDistance)
        return self[randomIndex]
    }
}
