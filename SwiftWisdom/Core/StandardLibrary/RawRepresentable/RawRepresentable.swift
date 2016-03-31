//
//  RawRepresentable.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 3/31/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension RawRepresentable where RawValue: IntegerType {
    public static var ip_allCases: [Self] {
        var caseIndex: RawValue = RawValue.allZeros//RawValue.init(0)
        let generator: () -> Self? = {
            let next = Self.init(rawValue: caseIndex)
            caseIndex = caseIndex.successor()
            return next
        }
        let sequence = AnyGenerator(body: generator)
        return [Self](sequence)
    }
}
