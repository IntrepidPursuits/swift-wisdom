//
//  UIViewController+Nibs.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

extension UIViewController {
    public static func ip_fromNib() -> Self {
        let controller = self.init(nibName: ip_nibName, bundle: nil)
        return controller
    }
    
    public static var ip_nibName: String {
        return "\(self)".components(separatedBy: ".").last!
    }
}
