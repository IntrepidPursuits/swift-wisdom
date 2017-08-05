//
//  UIView+Extensions.swift
//  SwiftWisdom
//
//  Created by Alexander Persian on 12/29/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

public extension UIView {

    /**
     Zooms a view by scaling it from its current transform using the provided factor.

     - parameter factor: Scaling factor. 1.0 = no change
     */
    func ip_zoom(by factor: CGFloat) {
        transform = transform.scaledBy(x: factor, y: factor)
    }

    /**
     Fades a view to alpha 0 over a specified duration. When the animation completes the alpha is returned to 1 to account 
     for the possiblity of the view's `hidden` property being set to false without the use of a fade method.
     
     - parameter duration: Length of time for the fade. Default = 0.2s
     */
    func ip_fadeOut(over duration: TimeInterval = 0.2) {
        UIView.animate(
            withDuration: duration,
            animations: {
                self.alpha = 0
            },
            completion: { [weak self] _ in
                self?.isHidden = true
                self?.alpha = 1
            }
        )
    }

    /**
     Fades a view to alpha 1 over a specified duration. This method can run into conflicts with `fadeOut`, so when finished 
     we force the `alpha` and `isHidden` properties to ensure the view displays correctly.

     - parameter duration: Length of time for the fade. Default = 0.2s
     */
    func ip_fadeIn(over duration: TimeInterval = 0.2) {
        if isHidden {
            alpha = 0
            isHidden = false
        }

        UIView.animate(
            withDuration: duration,
            animations: {
                self.alpha = 1
            },
            completion: { [weak self] _ in
                self?.alpha = 1
                self?.isHidden = false
            }
        )
    }
}
