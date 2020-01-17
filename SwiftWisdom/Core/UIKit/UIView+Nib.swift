//
//  UIView+Nib.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import UIKit

public extension UIView {
    class func ip_fromNib<T: UIView>(_ nibNameOrNil: String? = nil, type: T.Type = T.self, in bundle: Bundle = Bundle.main) -> T {
        return ip_fromNib(nibNameOrNil, type: type, in: bundle)!
    }

    //swiftlint:disable function_default_parameter_at_end
    class func ip_fromNib<T: UIView>(_ nibNameOrNil: String? = nil, type: T.Type, in bundle: Bundle = Bundle.main) -> T? {
        // Most nibs are demangled by practice, if not, just declare string explicitly
        let name = nibNameOrNil ?? ip_nibName
        let nibViews = bundle.loadNibNamed(name, owner: nil, options: nil)
        return nibViews?.first(where: { $0 is T }) as? T
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
