//
//  UIView+Nib.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import UIKit

public extension UIView {
    class func ip_fromNib(_ nibNameOrNil: String? = nil) -> Self {
        return ip_fromNib(nibNameOrNil, type: self)
    }

    //swiftlint:disable function_default_parameter_at_end
    class func ip_fromNib<T: UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T {
        let view: T? = ip_fromNib(nibNameOrNil, type: T.self)
        return view!
    }
    //swiftlint:enable function_default_parameter_at_end

    //swiftlint:disable function_default_parameter_at_end
    class func ip_fromNib<T: UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = ip_nibName
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for thisView in nibViews ?? [] {
            if let tog = thisView as? T {
                view = tog
            }
        }
        return view
    }
    //swiftlint:enable function_default_parameter_at_end

    class var ip_nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
    class var ip_nib: UINib? {
        if Bundle.main.path(forResource: ip_nibName, ofType: "nib") != nil {
            return UINib(nibName: ip_nibName, bundle: nil)
        } else {
            return nil
        }
    }
}
