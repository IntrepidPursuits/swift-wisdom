//
//  UIImage+Overlay.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/29/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     Takes an image and overlays it onto the calling image within its own coordinate space
     
     - parameter overlayImage: the image to overlay on top of the caller
     - parameter innerRect:    the rectangle to draw the overlay image in the caller's coordinate space
     
     - returns: the combination of the two images as a new UIImage object
     */
    public final func ip_overlayImage(_ overlayImage: UIImage, inRect innerRect: CGRect) -> UIImage {
        let outerRect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(outerRect.size)
        draw(in: outerRect)
        overlayImage.draw(in: innerRect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
}
