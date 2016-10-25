//
//  UIView+Nib.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import UIKit

extension Intrepid where Base: UIView {
    public static func fromNib(_ nibNameOrNil: String? = nil) -> UIView {
        return UIView.ip.fromNib(nibNameOrNil, type: UIView.self)
    }
    
    public static func fromNib<T : UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T {
        let v: T? = UIView.ip.fromNib(nibNameOrNil, type: T.self)
        return v!
    }
    
    public static func fromNib<T : UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = UIView.ip.nibName
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews ?? [] {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
    public static var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
    public static var nib: UINib? {
        if let _ = Bundle.main.path(forResource: UIView.ip.nibName, ofType: "nib") {
            return UINib(nibName: UIView.ip.nibName, bundle: nil)
        } else {
            return nil
        }
    }
}

