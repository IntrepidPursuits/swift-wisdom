//
//  Measurement+Extensions.swift
//  SwiftWisdom
//
//  Created by Gilmore, R. on 1/3/18.
//  Copyright © 2018 Intrepid. All rights reserved.
//

import Foundation

@available(iOS 10.0, *)
public extension Measurement where UnitType == UnitDuration {
    init(value: TimeInterval) {
        self.init(value: value, unit: UnitDuration.seconds)
    }
}
