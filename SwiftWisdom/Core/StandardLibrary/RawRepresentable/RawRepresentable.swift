//
//  RawRepresentable.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 3/31/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension RawRepresentable where RawValue: Integer {
    public static var ip_allCases: [Self] {
        var caseIndex: RawValue = RawValue.allZeros
        let generator: () -> Self? = {
            let next = Self.init(rawValue: caseIndex)
            caseIndex = caseIndex.advanced(by: 1)
            return next
        }
        
        let sequence = AnyIterator(generator)
        return [Self](sequence)
    }
}
