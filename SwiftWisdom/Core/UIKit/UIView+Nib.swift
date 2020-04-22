//
//  UIView+Nib.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import UIKit

public extension UIView {
    class func ip_fromNib(_ nibNameOrNil: String? = nil, in bundle: Bundle = Bundle.main) -> Self {
        // Most nibs are demangled by practice, if not, just declare string explicitly
        let name = nibNameOrNil ?? ip_nibName
        let nibViews = bundle.loadNibNamed(name, owner: nil, options: nil)
        guard let view = nibViews?.first as? Self else {
            fatalError("No nib with name \(name) found in bundle: \(bundle).")
        }
        return view
    }

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
