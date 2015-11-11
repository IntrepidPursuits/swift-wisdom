//
//  UIView+Nib.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import UIKit

public extension UITableView {
    public func ip_registerCell<T : UITableViewCell>(_: T.Type, identifier: String = T.ip_identifier) {
        if let nib = T.ip_nib {
            registerNib(nib, forCellReuseIdentifier: identifier)
        } else {
            registerClass(T.self, forCellReuseIdentifier: identifier)
        }
    }
    
    public func ip_registerHeader<T: UITableViewHeaderFooterView>(_: T.Type, identifier: String = T.ip_identifier) {
        if let nib = T.ip_nib {
            registerNib(nib, forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            registerClass(T.self, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
    
    public func ip_dequeueCell<T: UITableViewCell>(indexPath: NSIndexPath, identifier: String = T.ip_identifier) -> T {
        let cell = dequeueReusableCellWithIdentifier(T.ip_identifier, forIndexPath: indexPath) as! T
        return cell
    }
    
    public func ip_dequeueHeader<T: UITableViewHeaderFooterView>(section: Int, identifier: String = T.ip_identifier) -> T {
        let header = dequeueReusableHeaderFooterViewWithIdentifier(T.ip_identifier) as! T
        return header
    }
}

public extension UITableViewHeaderFooterView {
    public class var ip_nibName: String {
        let name = "\(self)".componentsSeparatedByString(".").first ?? ""
        return name
    }
    public class var ip_nib: UINib? {
        if let _ = NSBundle.mainBundle().pathForResource(ip_nibName, ofType: "nib") {
            return UINib(nibName: ip_nibName, bundle: nil)
        } else {
            return nil
        }
    }
    public class var ip_identifier: String {
        return "identifier:\(self)"
    }
}

public extension UITableViewCell {
    public class var ip_nibName: String {
        let name = "\(self)".componentsSeparatedByString(".").first ?? ""
        return name
    }
    public class var ip_nib: UINib? {
        if let _ = NSBundle.mainBundle().pathForResource(ip_nibName, ofType: "nib") {
            return UINib(nibName: ip_nibName, bundle: nil)
        } else {
            return nil
        }
    }
    public class var ip_identifier: String {
        return "identifier:\(self)"
    }
}
