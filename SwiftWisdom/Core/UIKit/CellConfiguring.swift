//
//  UIView+Nib.swift
//  ChristmasCheer
//
//  Created by Logan Wright on 10/25/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import UIKit

// MARK: TypeIdentifiable

public protocol TypeIdentifiable {
    static var ip_identifier: String { get }
}

extension TypeIdentifiable {
    public static var ip_identifier: String {
        return "identifier:\(self)"
    }
}

extension UITableViewCell: TypeIdentifiable {}
extension UITableViewHeaderFooterView: TypeIdentifiable {}

extension UICollectionReusableView: TypeIdentifiable {}

// MARK: UICollectionView

public extension UICollectionView {
    
    // MARK: Register

    public func ip_registerCell<T where T: UICollectionViewCell, T: TypeIdentifiable>(_: T.Type, identifier: String = T.ip_identifier) {
        if let nib = T.ip_nib {
            registerNib(nib, forCellWithReuseIdentifier: identifier)
        } else {
            registerClass(T.self, forCellWithReuseIdentifier: identifier)
        }
    }
    
    public func ip_registerHeader<T where T: UICollectionReusableView, T: TypeIdentifiable>(_: T.Type, identifier: String = T.ip_identifier) {
        ip_registerSupplementary(T.self, kind: UICollectionElementKindSectionHeader, identifier: identifier)
    }
    
    public func ip_registerFooter<T where T: UICollectionReusableView, T: TypeIdentifiable>(_: T.Type, identifier: String = T.ip_identifier) {
        ip_registerSupplementary(T.self, kind: UICollectionElementKindSectionFooter, identifier: identifier)
    }
    
    public func ip_registerSupplementary<T where T: UICollectionReusableView, T: TypeIdentifiable>(_: T.Type, kind: String, identifier: String = T.ip_identifier) {
        if let nib = T.ip_nib {
            registerNib(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        } else {
            registerClass(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        }
    }
    
    // MARK: Dequeue
    
    public func ip_dequeueCell<T where T: UICollectionViewCell, T: TypeIdentifiable>(indexPath: NSIndexPath, identifier: String = T.ip_identifier) -> T {
        return dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! T
    }
    
    public func ip_dequeueHeader<T where T: UICollectionReusableView, T: TypeIdentifiable>(indexPath: NSIndexPath, identifier: String = T.ip_identifier) -> T {
        return ip_dequeueSupplementary(indexPath, kind: UICollectionElementKindSectionHeader, identifier: identifier)
    }
    
    public func ip_dequeueFooter<T where T: UICollectionReusableView, T: TypeIdentifiable>(indexPath: NSIndexPath, identifier: String = T.ip_identifier) -> T {
        return ip_dequeueSupplementary(indexPath, kind: UICollectionElementKindSectionFooter, identifier: identifier)
    }
    
    public func ip_dequeueSupplementary<T where T: UICollectionReusableView, T: TypeIdentifiable>(indexPath: NSIndexPath, kind: String, identifier: String = T.ip_identifier) -> T {
        return dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: identifier, forIndexPath: indexPath) as! T
    }
    
}

// MARK: UITableView

public extension UITableView {
    
    // MARK: Register

    public func ip_registerCell<T where T: UITableViewCell, T: TypeIdentifiable>(_: T.Type, identifier: String = T.ip_identifier) {
        if let nib = T.ip_nib {
            registerNib(nib, forCellReuseIdentifier: identifier)
        } else {
            registerClass(T.self, forCellReuseIdentifier: identifier)
        }
    }
    
    public func ip_registerHeader<T where T: UITableViewHeaderFooterView, T: TypeIdentifiable>(_: T.Type, identifier: String = T.ip_identifier) {
        if let nib = T.ip_nib {
            registerNib(nib, forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            registerClass(T.self, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
    
    // MARK: Dequeue
    
    public func ip_dequeueCell<T where T: UITableViewCell, T: TypeIdentifiable>(indexPath: NSIndexPath, identifier: String = T.ip_identifier) -> T {
        return dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! T
    }
    
    public func ip_dequeueHeader<T where T: UITableViewHeaderFooterView, T: TypeIdentifiable>(section: Int, identifier: String = T.ip_identifier) -> T {
        return dequeueReusableHeaderFooterViewWithIdentifier(identifier) as! T
    }

    public func ip_cellForRowAtIndexPath<T where T: UITableViewCell, T: TypeIdentifiable>(indexPath: NSIndexPath) -> T {
        return cellForRowAtIndexPath(indexPath) as! T
    }
}
