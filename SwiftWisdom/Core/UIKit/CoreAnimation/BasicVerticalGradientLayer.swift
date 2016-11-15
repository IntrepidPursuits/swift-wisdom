//
//  CAGradientLayer.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 2/17/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

public final class BasicVerticalGradientLayer : CAGradientLayer {
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    public init(topColor: UIColor = .gray, bottomColor: UIColor = .black) {
        super.init()
        colors = [topColor.cgColor, bottomColor.cgColor]
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
