//
//  UIView+Nib.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import UIKit

public extension UITableView {
    public func registerCell<T : UITableViewCell>(_: T.Type, identifier: String = T.identifier) {
        if let nib = T.nib {
            registerNib(nib, forCellReuseIdentifier: identifier)
        } else {
            registerClass(T.self, forCellReuseIdentifier: identifier)
        }
    }
    
    public func registerHeader<T: UITableViewHeaderFooterView>(_: T.Type, identifier: String = T.identifier) {
        if let nib = T.nib {
            registerNib(nib, forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            registerClass(T.self, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
    
    public func dequeueCell<T: UITableViewCell>(indexPath: NSIndexPath, identifier: String = T.identifier) -> T {
        let cell = dequeueReusableCellWithIdentifier(T.identifier, forIndexPath: indexPath) as! T
        return cell
    }
    
    public func dequeueHeader<T: UITableViewHeaderFooterView>(section: Int, identifier: String = T.identifier) -> T {
        let header = dequeueReusableHeaderFooterViewWithIdentifier(T.identifier) as! T
        return header
    }
}

public extension UITableViewHeaderFooterView {
    public class var nibName: String {
        let name = "\(self)".componentsSeparatedByString(".").first ?? ""
        return name
    }
   public  class var nib: UINib? {
        if let _ = NSBundle.mainBundle().pathForResource(nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
    class var identifier: String {
        return "identifier:\(self)"
    }
}

extension UITableViewCell {
    class var nibName: String {
        let name = "\(self)".componentsSeparatedByString(".").first ?? ""
        return name
    }
    class var nib: UINib? {
        if let _ = NSBundle.mainBundle().pathForResource(nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
    class var identifier: String {
        return "identifier:\(self)"
    }
}
