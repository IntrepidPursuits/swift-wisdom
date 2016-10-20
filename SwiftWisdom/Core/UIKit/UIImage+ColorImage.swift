//
//  UIImage+ColorImage.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/29/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     Generates a plain image of a given color and size
     
     - parameter color: the color to generate the image from
     - parameter size:  the size of the image to generate.  Defaults to {1,1}
     
     - returns: a plain image of the given color
     */
    public static func ip_fromColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
}
