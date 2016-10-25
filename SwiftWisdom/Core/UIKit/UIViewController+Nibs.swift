//
//  UIViewController+Nibs.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 1/19/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import UIKit

extension Intrepid where Base: UIViewController {
    public static func fromNib() -> Base {
        let controller = Base.init(nibName: UIViewController.ip.nibName, bundle: nil)
        return controller
    }
    
    public static var nibName: String {
        return "\(self)".components(separatedBy: ".").last!
    }
}
