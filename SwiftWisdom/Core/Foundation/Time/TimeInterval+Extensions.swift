//
//  TimeInterval+Extensions.swift
//  SwiftWisdom
//
//  Created by Bob Gilmore on 1/3/18.
//  Copyright © 2018 Intrepid. All rights reserved.
//

import Foundation

public extension TimeInterval {
    @available(iOS 10.0, *)
    init(_ duration: Measurement<UnitDuration>) {
        self.init(duration.converted(to: .seconds).value)
    }
}
