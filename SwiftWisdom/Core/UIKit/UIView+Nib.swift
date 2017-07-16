//
//  UIView+Nib.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import UIKit

public extension UIView {
    public class func ip_fromNib(_ nibNameOrNil: String? = nil) -> Self {
        return ip_fromNib(nibNameOrNil, type: self)
    }

    public class func ip_fromNib<T: UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T {
        let v: T? = ip_fromNib(nibNameOrNil, type: T.self)
        return v!
    }

    public class func ip_fromNib<T: UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = ip_nibName
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews ?? [] {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }

    public class var ip_nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
    public class var ip_nib: UINib? {
        if Bundle.main.path(forResource: ip_nibName, ofType: "nib") != nil {
            return UINib(nibName: ip_nibName, bundle: nil)
        } else {
            return nil
        }
    }
}
