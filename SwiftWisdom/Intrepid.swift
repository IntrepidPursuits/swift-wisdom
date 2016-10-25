//
//  Intrepid.swift
//  SwiftWisdom
//
//  Created by Ayal Spitz on 10/25/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

public struct Intrepid<Base> {
    /// Base object to extend.
    public let base: Base
    
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has Intrepid extensions.
public protocol IntrepidCompatible {
    /// Extended type
    associatedtype CompatibleType
    
    /// Intrepid extensions.
    static var ip: Intrepid<CompatibleType>.Type { get set }
    
    /// Intrepid extensions.
    var ip: Intrepid<CompatibleType> { get set }
}

extension IntrepidCompatible {
    /// Intrepid extensions.
    public static var ip: Intrepid<Self>.Type {
        get { return Intrepid<Self>.self }
        set { /* this enables using Intrepid to "mutate" base type */ }
    }
    
    /// Intrepid extensions.
    public var ip: Intrepid<Self> {
        get { return Intrepid(self) }
        set { /* this enables using Intrepid to "mutate" base object */ }
    }
}

extension NSObject: IntrepidCompatible { }
