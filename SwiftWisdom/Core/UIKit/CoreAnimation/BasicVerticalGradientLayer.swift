//
//  CAGradientLayer.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 2/17/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

final class BasicVerticalGradientLayer : CAGradientLayer {
    init(topColor: UIColor = .grayColor(), bottomColor: UIColor = .blackColor()) {
        super.init()
        colors = [topColor.CGColor, bottomColor.CGColor]
        locations = [0, 1.0]
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
