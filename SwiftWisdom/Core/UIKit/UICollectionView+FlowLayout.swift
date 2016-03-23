//
//  UICollectionView+FlowLayout.swift
//  Pods
//
//  Created by Ying Quan Tan on 3/22/16.
//
//

import Foundation

public extension UICollectionView {
    /**
     Returns the UICollectionViewFlowLayout associated with a view, if there is one.
     */
    var ip_flowLayout: UICollectionViewFlowLayout? {
        return self.collectionViewLayout as? UICollectionViewFlowLayout
    }
}
