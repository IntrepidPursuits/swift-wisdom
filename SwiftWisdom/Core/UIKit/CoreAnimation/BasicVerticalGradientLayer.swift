//
//  CAGradientLayer.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 2/17/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

public final class BasicVerticalGradientLayer : CAGradientLayer {
    public init(topColor: UIColor = .grayColor(), bottomColor: UIColor = .blackColor()) {
        super.init()
        colors = [topColor.CGColor, bottomColor.CGColor]
        locations = [0, 1.0]
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
