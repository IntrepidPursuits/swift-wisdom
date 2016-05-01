//
//  DecimalFormatter.swift
//  SwiftWisdom
//
//  Created by Stephen Wong on 5/1/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

final class DecimalFormatter: NSNumberFormatter {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override private init() {
        super.init()
        self.numberStyle = .DecimalStyle
        self.minimumFractionDigits = 0
    }
    
    static let sharedInstance = DecimalFormatter()
}
