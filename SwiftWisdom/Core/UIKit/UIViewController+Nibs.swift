//
//  UIViewController+Nibs.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

extension UIViewController {
    static func ip_fromNib() -> Self {
        let controller = self.init(nibName: ip_nibName, bundle: nil)
        return controller
    }
}

extension UIViewController {
    class var ip_nibName: String {
        return "\(self)".componentsSeparatedByString(".").last!
    }
}
