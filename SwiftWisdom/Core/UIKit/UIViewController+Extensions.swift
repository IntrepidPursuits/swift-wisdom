//
//  UIViewController+Extensions.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 12/16/15.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

extension UIViewController {

    /// Remove all child view controllers from this UIViewController.
    public final func ip_removeAllChildViewControllers() {
        childViewControllers.forEach { (viewController) in
            viewController.ip_removeFromParentViewController()
        }
    }

    /// Returns all the controllers presented on this UIViewController.
    public final var ip_allPresentedViewControllers: [UIViewController] {
        var controllers = [UIViewController]()
        var presented: UIViewController? = self
        while let vc = presented?.presentedViewController {
            controllers.append(vc)
            presented = vc
        }
        return controllers
    }
}
